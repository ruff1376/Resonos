import {
    Chart,
    DoughnutController,
    ArcElement,
    Tooltip,
    Legend
} from 'chart.js';
Chart.register(DoughnutController, ArcElement, Tooltip, Legend);
import { useEffect } from 'react';
import 'bootstrap/dist/css/bootstrap.min.css';
import '../List/MainForm.css'
import Pagination from '../Pagination/Pagination';
import ScrollToTop from '../ScrollToTop/ScrollToTop';
import { Link } from 'react-router-dom';

const chartInstances = new Map();

export default function AlbumSearchForm({
    keyword,
    albumSearchList = [],
    albumSearchCount = 0,
    pagination = [],
    onPageChange = () => {},
    handleSortChange = () => {},
    sort = "relevance"
}) {
    useEffect(() => {
        document.querySelectorAll('.doughnut-canvas').forEach((canvas) => {
            const id = canvas.dataset.chartid || canvas.id;

            // 기존 차트 인스턴스 제거
            if (chartInstances.has(id)) {
                chartInstances.get(id).destroy();
                chartInstances.delete(id);
            }

            const value = parseInt(canvas.dataset.rating);
            let color = value >= 70 ? '#4CAF50' : value >= 50 ? '#FFC107' : '#F44336';
            const isFirst = canvas.dataset.first === "true";
            const fontSize = isFirst ? 20 : 14;
            const ctx = canvas.getContext('2d');

            const centerTextPlugin = {
                id: 'centerText',
                afterDraw(chart) {
                    const { ctx, chartArea: { width, height } } = chart;
                    ctx.save();
                    ctx.font = `bold ${fontSize}px sans-serif`;
                    ctx.fillStyle = color;
                    ctx.textAlign = 'center';
                    ctx.textBaseline = 'middle';
                    ctx.fillText(value, width / 2, height / 2);
                    ctx.restore();
                }
            };

            const chart = new Chart(ctx, {
                type: 'doughnut',
                data: {
                    datasets: [{
                        data: [value, 100 - value],
                        backgroundColor: [color, 'white'],
                        borderWidth: 0
                    }]
                },
                options: {
                    responsive: false,
                    cutout: '70%',
                    plugins: {
                        tooltip: { enabled: false },
                        legend: { display: false }
                    }
                },
                plugins: [centerTextPlugin]
            });

            chartInstances.set(id, chart);
        });
    }, [albumSearchList]);

    return (
        <div
            className="container-fluid d-flex flex-column align-items-center px-0"
            style={{ maxWidth: 1440, paddingTop: 150, gap: 50 }}
        >
            {/* 검색 결과 제목 */}
            <div
                className="d-flex flex-row mb-5 w-100"
                style={{ maxWidth: 1440, margin: "10px auto", gap: 10 }}
            >
                <h1 style={{ color: "white", marginLeft: "3rem" }}>
                    검색 결과 : "<span>{keyword || "검색어"}</span>" (<span>{albumSearchCount ?? 0}</span>건)
                </h1>
            </div>

            <section className="main-section-bg w-100 py-4 mb-5">
                <div
                    className="d-flex flex-row align-items-center px-4 mb-3"
                    style={{ height: 50 }}
                >
                    <div className="section-title flex-grow-1">앨범</div>
                    <form
                        method="get"
                        action="/search/albums"
                        style={{ display: "inline-block" }}
                    >
                        <input type="hidden" name="q" value={keyword} />
                        <input type="hidden" name="page" value={pagination.page ?? 1} />
                        <select
                            className="select-sort"
                            name="sort"
                            value={sort}
                            onChange={handleSortChange}
                        >
                            <option value="relevance">정확도</option>
                            <option value="latest">최신순</option>
                            <option value="popular">인기순</option>
                        </select>
                    </form>
                </div>
                {!albumSearchList || albumSearchList.length === 0 ? (
                    <div
                        style={{
                            borderTop: "1px solid #D4B97F",
                            borderBottom: "1px solid #D4B97F",
                            padding: "40px 0",
                        }}
                    >
                        <div className="d-flex justify-content-center align-items-center">
                            <h3 style={{ color: "#B1B1B1" }}>검색된 앨범이 없습니다.</h3>
                        </div>
                    </div>
                ) : (
                    <div className="album-grid row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-6 g-0 m-0 justify-content-start">
                        {albumSearchList.map((album) => (
                            <div className="col d-flex justify-content-center" key={album.id}>
                                <div
                                    className="card align-items-center p-3"
                                    style={{ width: 228, height: 340 }}
                                >
                                    <Link to={`/albums?id=${album.id}`}>
                                        <img
                                            src={album.coverImage}
                                            className="card-img-top"
                                            alt="앨범커버"
                                        />
                                    </Link>
                                    <div className="card-body d-flex flex-column align-items-center">
                                        <Link to={`/albums?id=${album.id}`} className="card-title">
                                            {album.title}
                                        </Link>
                                        <Link to={`/artists?id=${album.artistId}`} className="card-artist">
                                            {album.artistName}
                                        </Link>
                                    </div>
                                    <div className="d-flex justify-content-center mb-4">
                                        {album.avgRating != null ? (
                                            <canvas
                                                className="doughnut-canvas"
                                                data-rating={album.avgRating}
                                                width="50"
                                                height="50"
                                                data-chartid={`album-${album.id}`}
                                            />
                                        ) : (
                                            <span className="no-rating fw-bold fs-2 pb-3">NR</span>
                                        )}
                                    </div>
                                </div>
                            </div>
                        ))}
                    </div>
                )}
                <Pagination pagination={pagination} onPageChange={onPageChange} handleSortChange={handleSortChange} />
            </section>

            <ScrollToTop />
        </div>
    );
}
