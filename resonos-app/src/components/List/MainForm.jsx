import { useEffect } from 'react';
import { Chart } from 'chart.js';

export default function MainForm({
    korHotReviewAlbumList = [],
    worldHotReviewAlbumList = [],
    newAlbumList = [],
    hotAlbumList = [],
    newTrackList = [],
    hotTrackList = [],
    newPlaylistList = [],
    hotPlaylistList = [],
    newAlbumCount = 0,
    hotAlbumCount = 0,
    newTrackCount = 0,
    hotTrackCount = 0,
    newPlaylistCount = 0,
    hotPlaylistCount = 0
}) {
    useEffect(() => {
        document.querySelectorAll('.doughnut-canvas').forEach((canvas) => {
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

            new Chart(ctx, {
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
        });
    }, [korHotReviewAlbumList, worldHotReviewAlbumList, newAlbumList, hotAlbumList, newTrackList, hotTrackList]);

    return (
        <div className="container-fluid d-flex flex-column align-items-center px-0" style={{ maxWidth: 1440, paddingTop: 50, gap: 50 }}>
            <AlbumSection title="🔥🇰🇷리뷰 급상승 국내 앨범" albumList={korHotReviewAlbumList} />
            <AlbumSection title="🔥🌎리뷰 급상승 해외 앨범" albumList={worldHotReviewAlbumList} />

            <GridSection title="최신 앨범" albumList={newAlbumList} count={newAlbumCount} moreLink="/list/new-albums" />
            <GridSection title="인기 앨범" albumList={hotAlbumList} count={hotAlbumCount} moreLink="/list/hot-albums" />
            <GridSection title="최신 트랙" albumList={newTrackList} count={newTrackCount} moreLink="/list/new-tracks" isTrack />
            <GridSection title="인기 트랙" albumList={hotTrackList} count={hotTrackCount} moreLink="/list/hot-tracks" isTrack />
            <GridSection title="최신 플레이리스트" albumList={newPlaylistList} count={newPlaylistCount} moreLink="/list/new-playlists" isPlaylist />
            <GridSection title="인기 플레이리스트" albumList={hotPlaylistList} count={hotPlaylistCount} moreLink="/list/hot-playlists" isPlaylist />

            <div className="floating">
                <a href="#">
                    <i className="bi bi-caret-up-fill"></i>
                </a>
            </div>
        </div>
    );
}

function AlbumSection({ title, albumList }) {
    return (
        <div className="d-flex flex-row mb-5 w-100" style={{ maxWidth: 1440, margin: '10px auto', gap: 10 }}>
            <div className="d-flex flex-column align-items-start justify-content-start p-0" style={{ width: '100%', margin: 50 }}>
                <div className="main-title py-3 px-4 w-100">{title}</div>
                <div className="d-flex flex-column justify-content-start gap-3 w-100" style={{ margin: '20px 10px' }}>
                    {albumList.map((album, idx) => (
                        <a key={album.id} href={`/albums?id=${album.id}`} className={`album-card${idx === 0 ? '' : ' secondary'} d-flex flex-row align-items-center justify-content-between px-4 py-3 gap-4 w-100 position-relative`}>
                            <div className="d-flex align-items-center gap-4 flex-shrink-1" style={{ minWidth: 0 }}>
                                <div className={`album-rank ${idx === 0 ? 'top' : ''}`}>{idx + 1}</div>
                                <img src={album.coverImage} alt="앨범커버" className="album-img" />
                                <div className="d-flex flex-column justify-content-center" style={{ minWidth: 180, maxWidth: 400, overflow: 'hidden' }}>
                                    <div className="album-title">{album.title}</div>
                                    <div className="album-artist">{album.artistName}</div>
                                </div>
                            </div>
                            <div className="d-flex justify-content-end align-items-center me-4" style={{ flexShrink: 0 }}>
                                {album.avgRating != null ? (
                                    <canvas
                                        className="doughnut-canvas"
                                        data-rating={album.avgRating}
                                        width={idx === 0 ? 75 : 50}
                                        height={idx === 0 ? 75 : 50}
                                        data-first={idx === 0 ? 'true' : undefined}
                                    ></canvas>
                                ) : (
                                    <span className="no-rating me-4 fw-bold fs-2">NR</span>
                                )}
                            </div>
                        </a>
                    ))}
                </div>
            </div>
        </div>
    );
}

function GridSection({ title, albumList, count, moreLink, isTrack = false, isPlaylist = false }) {
    return (
        <section className="main-section-bg w-100 py-4 mb-5">
            <div className="d-flex flex-row align-items-center px-4 mb-3" style={{ height: 50 }}>
                <div className="section-title flex-grow-1">{title}</div>
            </div>
            <div className="album-grid row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-6 g-0 m-0 justify-content-start">
                {albumList.map((item) => (
                    <div key={item.id} className="col d-flex justify-content-center">
                        <div className={`card align-items-center ${isPlaylist ? 'p-3' : 'gap-2 mt-3'}`} style={{ width: 228, height: isPlaylist ? 240 : 340 }}>
                            <a href={`/${isPlaylist ? 'playlists' : isTrack ? 'tracks' : 'albums'}${isPlaylist ? '/' + item.id : '?id=' + item.id}`}>
                                <img src={isPlaylist ? item.thumbnailUrl : item.coverImage} className="card-img-top" alt="썸네일" />
                            </a>
                            <div className="card-body d-flex flex-column align-items-center">
                                <a href={`/${isPlaylist ? 'playlists' : isTrack ? 'tracks' : 'albums'}${isPlaylist ? '/' + item.id : '?id=' + item.id}`} className="card-title">
                                    {item.title}
                                </a>
                                <a href={`/${isPlaylist ? 'users' : 'artists'}${isPlaylist ? '/' + item.userId : '?id=' + item.artistId}`} className="card-artist">
                                    {isPlaylist ? `제작자 : ${item.maker}` : item.artistName}
                                </a>
                                {isPlaylist && (
                                    <div className="card-artist">♥ {item.likeCount?.toLocaleString() ?? 0}</div>
                                )}
                            </div>
                            <div className="d-flex justify-content-center mb-4">
                                {item.avgRating != null ? (
                                    <canvas className="doughnut-canvas" data-rating={item.avgRating} width={50} height={50}></canvas>
                                ) : (
                                    <span className="no-rating fw-bold fs-2 pb-3">NR</span>
                                )}
                            </div>
                        </div>
                    </div>
                ))}
            </div>
            {count > 12 && (
                <div className="d-flex flex-row align-items-center justify-content-end px-4 mb-3" style={{ height: 50 }}>
                    <a href={moreLink} className="more-link">더 보기 &gt;</a>
                </div>
            )}
        </section>
    );
}
