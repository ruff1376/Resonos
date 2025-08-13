import { Link } from "react-router-dom";
import Pagination from "../../Pagination/Pagination";

export default function TrackSearchGridSection({
    keyword,
    trackSearchList,
    trackSearchCount,
    pagination,
    onPageChange,
    handleSortChange,
    sort,
    showPagination = false
}) {

    const showMoreButton = !showPagination && trackSearchCount > 12;

    return (
        <section className="main-section-bg w-100 py-4 mb-5">
            <div
                className="d-flex flex-row align-items-center px-4 mb-3"
                style={{ height: 50 }}
            >
                <div className="section-title flex-grow-1">트랙</div>
                {showPagination && (
                    <form
                        method="get"
                        action="/search/tracks"
                        style={{ display: "inline-block" }}
                    >
                        <input type="hidden" name="q" value={keyword} />
                        <input type="hidden" name="page" value={pagination?.page ?? 1} />
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
                )}
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
                                className="card align-items-center p-3"
                                style={{ width: 228, height: 340 }}
                            >
                                <Link to={`/tracks?id=${track.id}`}>
                                    <img
                                        src={track.coverImage}
                                        className="card-img-top"
                                        alt="앨범커버"
                                    />
                                </Link>
                                <div className="card-body d-flex flex-column align-items-center">
                                    <Link to={`/tracks?id=${track.id}`} className="card-title">
                                        {track.title}
                                    </Link>
                                    <Link to={`/artists?id=${track.artistId}`} className="card-artist">
                                        {track.artistName}
                                    </Link>
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
            {showMoreButton && (
                <div className="d-flex flex-row align-items-center justify-content-end px-4 mb-3" style={{ height: 50 }}>
                    <Link to={`/search/tracks?q=${keyword}`} className="more-link">
                        더 보기 &gt;
                    </Link>
                </div>
            )}
            {showPagination && (
                <Pagination pagination={pagination} onPageChange={onPageChange} handleSortChange={handleSortChange} />
            )}
        </section>
    );
}