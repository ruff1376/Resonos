import {
    Chart,
    DoughnutController,
    ArcElement,
    Tooltip,
    Legend
} from 'chart.js';
Chart.register(DoughnutController, ArcElement, Tooltip, Legend);
import { useEffect, useRef } from 'react';
import 'bootstrap/dist/css/bootstrap.min.css';
import './MainForm.css'
import Pagination from '../Pagination/Pagination';

const chartInstances = new Map();

export default function NewAlbumForm({
    newAlbumList = [],
    newAlbumCount = 0,
    pagination = [],
    onPageChange = () => {}
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
    }, [newAlbumList]);

    return (
        <div className="container-fluid d-flex flex-column align-items-center px-0" style={{ maxWidth: 1440, paddingTop: 50, gap: 50 }}>
            <GridSection
                title="최신 앨범"
                albumList={newAlbumList}
                count={newAlbumCount}
                pagination={pagination}
                onPageChange={onPageChange}
            />

            <div className="floating">
                <a href="#">
                    <i className="bi bi-caret-up-fill"></i>
                </a>
            </div>
        </div>
    );
}

function GridSection({ title, albumList, pagination, onPageChange}) {
    return (
        <section className="main-section-bg w-100 py-4 mb-5">
            <div className="d-flex flex-row align-items-center px-4 mb-3" style={{ height: 50 }}>
                <div className="section-title flex-grow-1">{title}</div>
            </div>
            <div className="album-grid row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-6 g-0 m-0 justify-content-start">
                {albumList.map((album) => (
                    <div key={album.id} className="col d-flex justify-content-center">
                        <div className={'card align-items-center gap-2 mt-3'} style={{ width: 228, height: 340 }}>
                            <a href={'/albums?id=' + album.id}>
                                <img src={album.coverImage} className="card-img-top" alt="앨범커버" />
                            </a>
                            <div className="card-body d-flex flex-column align-items-center">
                                <a href={'/albums?id=' + album.id} className="card-title">
                                    {album.title}
                                </a>
                                <a href={'/artists?id=' + album.artistId} className="card-artist">
                                    {album.artistName}
                                </a>
                            </div>
                            <div className="d-flex justify-content-center mb-4">
                                {album.avgRating != null ? (
                                    <canvas
                                        className="doughnut-canvas"
                                        data-rating={album.avgRating}
                                        width={50}
                                        height={50}
                                        data-chartid={`${'album'}-${album.id}`}
                                    ></canvas>
                                ) : (
                                    <span className="no-rating fw-bold fs-2 pb-3">NR</span>
                                )}
                            </div>
                        </div>
                    </div>
                ))}
            </div>
            <Pagination pagination={pagination} onPageChange={onPageChange} />
        </section>
    );
}
