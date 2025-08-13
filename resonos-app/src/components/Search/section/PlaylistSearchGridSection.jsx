import { Link } from "react-router-dom";
import Pagination from "../../Pagination/Pagination";

export default function PlaylistSearchGridSection({
    keyword,
    playlistSearchList,
    playlistSearchCount,
    pagination,
    onPageChange,
    showPagination = false
}) {

    const formatNumber = (num) => num?.toLocaleString("ko-KR") || "0";

    const showMoreButton = !showPagination && playlistSearchCount > 12;

    return (
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
                <div className="album-grid row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-6 g-0 m-0 justify-content-start" style={{ rowGap: "4rem" }}>
                    {playlistSearchList.map((playlist) => (
                        <div className="col d-flex justify-content-center" key={playlist.id}>
                            <div
                                className="card align-items-center p-3"
                                style={{ width: 228, height: 240 }}
                            >
                                <Link to={`/playlists/${playlist.id}`}>
                                    <img
                                        src={playlist.thumbnailUrl}
                                        className="card-img-top"
                                        alt="썸네일"
                                    />
                                </Link>
                                <div className="card-body d-flex flex-column align-items-center">
                                    <Link to={`/playlists/${playlist.id}`} className="card-title">
                                        {playlist.title}
                                    </Link>
                                    <div className="card-artist no-hover">
                                        <span>제작자 : </span>
                                        <Link to={'/users/' + playlist.maker} className="card-artist">
                                            {playlist.maker}
                                        </Link>
                                    </div>
                                    <div className="card-artist no-hover">♥ {formatNumber(playlist.likeCount)}</div>
                                </div>
                            </div>
                        </div>
                    ))}
                </div>
            )}
            {showMoreButton && (
                <div className="d-flex flex-row align-items-center justify-content-end px-4 mb-3" style={{ height: 50 }}>
                    <Link to={`/search/playlists?q=${keyword}`} className="more-link">
                        더 보기 &gt;
                    </Link>
                </div>
            )}
            {showPagination && (
                <Pagination pagination={pagination} onPageChange={onPageChange} />
            )}
        </section>
    );
}