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

const chartInstances = new Map();

export default function SearchForm({
    keyword,
    artistSearchList = [],
    albumSearchList = [],
    trackSearchList = [],
    userSearchList = [],
    playlistSearchList = [],
    searchTracksByTagList = [],
    artistSearchCount = 0,
    albumSearchCount = 0,
    trackSearchCount = 0,
    userSearchCount = 0,
    playlistSearchCount = 0
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
    }, [albumSearchList, trackSearchList, searchTracksByTagList]);

    const isTagSearch = keyword?.startsWith("#");

    const formatNumber = (num) =>
        num?.toLocaleString("ko-KR") || "0";

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
                    검색 결과 : "<span>{keyword || "검색어"}</span>"
                </h1>
            </div>

            {/* 아티스트 */}
            {!isTagSearch && (
                <section className="main-section-bg w-100 py-4 mb-5">
                    <div
                        className="d-flex flex-row align-items-center px-4 mb-3"
                        style={{ height: 50 }}
                    >
                        <div className="section-title flex-grow-1">아티스트</div>
                    </div>
                    {!artistSearchList || artistSearchList.length === 0 ? (
                        <div
                            style={{
                                borderTop: "1px solid #D4B97F",
                                borderBottom: "1px solid #D4B97F",
                                padding: "40px 0",
                            }}
                        >
                            <div className="d-flex justify-content-center align-items-center">
                                <h3 style={{ color: "#B1B1B1" }}>검색된 아티스트가 없습니다.</h3>
                            </div>
                        </div>
                    ) : (
                        <div className="album-grid row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-6 g-0 m-0 justify-content-start">
                            {artistSearchList.map((artist) => (
                                <div className="col d-flex justify-content-center" key={artist.id}>
                                    <div
                                        className="card align-items-center p-3"
                                        style={{ width: 228, height: 230 }}
                                    >
                                        <a href={`/artists?id=${artist.id}`}>
                                            <img
                                                src={artist.profileImage}
                                                className="card-img-top rounded-circle"
                                                alt="아티스트 이미지"
                                            />
                                        </a>
                                        <div className="card-body">
                                            <a href={`/artists?id=${artist.id}`} className="card-title">
                                                {artist.name}
                                            </a>
                                            <div className="card-artist">
                                                {formatNumber(artist.followerCount)} 팔로워
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            ))}
                        </div>
                    )}
                    {artistSearchCount > 6 && (
                        <div
                            className="d-flex flex-row align-items-center justify-content-end px-4 mb-3"
                            style={{ height: 50 }}
                        >
                            <a href={`/search/artists?q=${keyword}`} className="more-link">
                                더 보기 &gt;
                            </a>
                        </div>
                    )}
                </section>
            )}

            {/* 앨범 */}
            {!isTagSearch && (
                <section className="main-section-bg w-100 py-4 mb-5">
                    <div
                        className="d-flex flex-row align-items-center px-4 mb-3"
                        style={{ height: 50 }}
                    >
                        <div className="section-title flex-grow-1">앨범</div>
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
                                        className="card align-items-center gap-2 mt-3"
                                        style={{ width: 228, height: 340 }}
                                    >
                                        <a href={`/albums?id=${album.id}`}>
                                            <img
                                                src={album.coverImage}
                                                className="card-img-top"
                                                alt="앨범커버"
                                            />
                                        </a>
                                        <div className="card-body d-flex flex-column align-items-center">
                                            <a href={`/albums?id=${album.id}`} className="card-title">
                                                {album.title}
                                            </a>
                                            <a href={`/artists?id=${album.artistId}`} className="card-artist">
                                                {album.artistName}
                                            </a>
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
                    {albumSearchCount > 12 && (
                        <div
                            className="d-flex flex-row align-items-center justify-content-end px-4 mb-3"
                            style={{ height: 50 }}
                        >
                            <a href={`/search/albums?q=${keyword}`} className="more-link">
                                더 보기 &gt;
                            </a>
                        </div>
                    )}
                </section>
            )}

            {/* 트랙 */}
            {!isTagSearch && (
                <section className="main-section-bg w-100 py-4 mb-5">
                    <div
                        className="d-flex flex-row align-items-center px-4 mb-3"
                        style={{ height: 50 }}
                    >
                        <div className="section-title flex-grow-1">트랙</div>
                    </div>
                    {!trackSearchList || trackSearchList.length === 0 ? (
                        <div
                            style={{
                                borderTop: "1px solid #D4B97F",
                                borderBottom: "1px solid #D4B97F",
                                padding: "40px 0",
                            }}
                        >
                            <div className="d-flex justify-content-center align-items-center">
                                <h3 style={{ color: "#B1B1B1" }}>검색된 트랙이 없습니다.</h3>
                            </div>
                        </div>
                    ) : (
                        <div className="album-grid row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-6 g-0 m-0 justify-content-start">
                            {trackSearchList.map((track) => (
                                <div className="col d-flex justify-content-center" key={track.id}>
                                    <div
                                        className="card align-items-center gap-2 mt-3"
                                        style={{ width: 228, height: 340 }}
                                    >
                                        <a href={`/tracks?id=${track.id}`}>
                                            <img
                                                src={track.coverImage}
                                                className="card-img-top"
                                                alt="앨범커버"
                                            />
                                        </a>
                                        <div className="card-body d-flex flex-column align-items-center">
                                            <a href={`/tracks?id=${track.id}`} className="card-title">
                                                {track.title}
                                            </a>
                                            <a href={`/artists?id=${track.artistId}`} className="card-artist">
                                                {track.artistName}
                                            </a>
                                        </div>
                                        <div className="d-flex justify-content-center mb-4">
                                            {track.avgRating != null ? (
                                                <canvas
                                                    className="doughnut-canvas"
                                                    data-rating={track.avgRating}
                                                    width="50"
                                                    height="50"
                                                    data-chartid={`track-${track.id}`}
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
                    {trackSearchCount > 12 && (
                        <div
                            className="d-flex flex-row align-items-center justify-content-end px-4 mb-3"
                            style={{ height: 50 }}
                        >
                            <a href={`/search/tracks?q=${keyword}`} className="more-link">
                                더 보기 &gt;
                            </a>
                        </div>
                    )}
                </section>
            )}

            {/* 회원 */}
            {!isTagSearch && (
                <section className="main-section-bg w-100 py-4 mb-5">
                    <div
                        className="d-flex flex-row align-items-center px-4 mb-3"
                        style={{ height: 50 }}
                    >
                        <div className="section-title flex-grow-1">회원</div>
                    </div>
                    {!userSearchList || userSearchList.length === 0 ? (
                        <div
                            style={{
                                borderTop: "1px solid #D4B97F",
                                borderBottom: "1px solid #D4B97F",
                                padding: "40px 0",
                            }}
                        >
                            <div className="d-flex justify-content-center align-items-center">
                                <h3 style={{ color: "#B1B1B1" }}>검색된 회원이 없습니다.</h3>
                            </div>
                        </div>
                    ) : (
                        <div className="album-grid row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-6 g-0 m-0 justify-content-start">
                            {userSearchList.map((user) => (
                                <div className="col d-flex justify-content-center" key={user.id}>
                                    <div
                                        className="card align-items-center p-3"
                                        style={{ width: 228, height: 230 }}
                                    >
                                        <a href={`/users/${user.id}`}>
                                            <img
                                                src={user.profileImage}
                                                className="card-img-top rounded-circle"
                                                alt="회원 이미지"
                                            />
                                        </a>
                                        <div className="card-body">
                                            <a href={`/users/${user.id}`} className="card-title">
                                                {user.nickname}
                                            </a>
                                            <div className="card-artist">
                                                {formatNumber(user.followerCount)} 팔로워
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            ))}
                        </div>
                    )}
                    {userSearchCount > 6 && (
                        <div
                            className="d-flex flex-row align-items-center justify-content-end px-4 mb-3"
                            style={{ height: 50 }}
                        >
                            <a href={`/search/users?q=${keyword}`} className="more-link">
                                더 보기 &gt;
                            </a>
                        </div>
                    )}
                </section>
            )}

            {/* 플레이리스트 */}
            {!isTagSearch && (
                <section className="main-section-bg w-100 py-4 mb-5">
                    <div
                        className="d-flex flex-row align-items-center px-4 mb-3"
                        style={{ height: 50 }}
                    >
                        <div className="section-title flex-grow-1">플레이리스트</div>
                    </div>
                    {!playlistSearchList || playlistSearchList.length === 0 ? (
                        <div
                            style={{
                                borderTop: "1px solid #D4B97F",
                                borderBottom: "1px solid #D4B97F",
                                padding: "40px 0",
                            }}
                        >
                            <div className="d-flex justify-content-center align-items-center">
                                <h3 style={{ color: "#B1B1B1" }}>검색된 플레이리스트가 없습니다.</h3>
                            </div>
                        </div>
                    ) : (
                        <div className="album-grid row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-6 g-0 m-0 justify-content-start">
                            {playlistSearchList.map((playlist) => (
                                <div className="col d-flex justify-content-center" key={playlist.id}>
                                    <div
                                        className="card align-items-center p-3"
                                        style={{ width: 228, height: 240 }}
                                    >
                                        <a href={`/playlists/${playlist.id}`}>
                                            <img
                                                src={playlist.thumbnailUrl}
                                                className="card-img-top"
                                                alt="플레이리스트 썸네일"
                                            />
                                        </a>
                                        <div className="card-body">
                                            <a href={`/playlists/${playlist.id}`} className="card-title">
                                                {playlist.title}
                                            </a>
                                            <a href={`/users/${playlist.userId}`} className="card-artist">
                                                제작자 : {playlist.maker}
                                            </a>
                                            <div className="card-artist">♥ {formatNumber(playlist.likeCount)}</div>
                                        </div>
                                    </div>
                                </div>
                            ))}
                        </div>
                    )}
                    {playlistSearchCount > 12 && (
                        <div
                            className="d-flex flex-row align-items-center justify-content-end px-4 mb-3"
                            style={{ height: 50 }}
                        >
                            <a href={`/search/playlists?q=${keyword}`} className="more-link">
                                더 보기 &gt;
                            </a>
                        </div>
                    )}
                </section>
            )}

            {/* 태그 */}
            {isTagSearch && (
                <section className="main-section-bg w-100 py-4 mb-5">
                    {!searchTracksByTagList || searchTracksByTagList.length === 0 ? (
                        <div
                            style={{
                                borderTop: "1px solid #D4B97F",
                                borderBottom: "1px solid #D4B97F",
                                padding: "40px 0",
                            }}
                        >
                            <div className="d-flex justify-content-center align-items-center">
                                <h3 style={{ color: "#B1B1B1" }}>검색된 태그가 없습니다.</h3>
                            </div>
                        </div>
                    ) : (
                        <div className="album-grid row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-6 g-0 m-0 justify-content-start">
                            {searchTracksByTagList.map((track) => (
                                <div className="col d-flex justify-content-center" key={track.id}>
                                    <div
                                        className="card align-items-center gap-2 mt-3"
                                        style={{ width: 228 }}
                                    >
                                        <a href={`/tracks?id=${track.id}`}>
                                            <img
                                                src={track.coverImage}
                                                className="card-img-top"
                                                alt="앨범커버"
                                            />
                                        </a>
                                        <div className="card-body d-flex flex-column align-items-center">
                                            <a href={`/tracks?id=${track.id}`} className="card-title">
                                                {track.title}
                                            </a>
                                            <a href={`/artists?id=${track.artistId}`} className="card-artist">
                                                {track.artistName}
                                            </a>
                                            <a
                                                className="card-artist"
                                                style={{ textDecoration: "none", cursor: "default" }}
                                            >
                                                {track.voteCount}
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            ))}
                        </div>
                    )}
                </section>
            )}

            {/* 위로가기 플로팅 버튼 */}
            <div className="floating">
                <a href="#">
                    <i className="bi bi-caret-up-fill"></i>
                </a>
            </div>
        </div>
    );
}
