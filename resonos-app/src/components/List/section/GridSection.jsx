import { Link } from "react-router-dom";

export default function GridSection({
    title,
    contentList,
    count,
    moreLink,
    isTrack = false,
    isPlaylist = false,
}) {
    return (
        <section className="main-section-bg w-100 py-4 mb-5">
            <div
                className="d-flex flex-row align-items-center px-4 mb-3"
                style={{ height: 50 }}
            >
                <div className="section-title flex-grow-1">{title}</div>
            </div>
            <div
                className="album-grid row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-6 g-0 m-0 justify-content-start"
                style={
                    isPlaylist ? { rowGap: "4rem", padding: "50px 0" } : {}
                }
            >
                {contentList.map((content) => (
                    <div key={content.id} className="col d-flex justify-content-center">
                        <div
                            className={`card align-items-center ${isPlaylist ? "p-3" : "gap-2 mt-3"
                                }`}
                            style={{
                                width: 228,
                                height: isPlaylist ? 240 : 340,
                            }}
                        >
                            <Link
                                to={`/${isPlaylist
                                        ? "playlists"
                                        : isTrack
                                            ? "tracks"
                                            : "albums"
                                    }${isPlaylist
                                        ? "/" + content.id
                                        : "?id=" + content.id
                                    }`}
                            >
                                <img
                                    src={
                                        isPlaylist
                                            ? content.thumbnailUrl
                                            : content.coverImage
                                    }
                                    className="card-img-top"
                                    alt="썸네일"
                                />
                            </Link>
                            <div className="card-body d-flex flex-column align-items-center">
                                <Link
                                    to={`/${isPlaylist
                                            ? "playlists"
                                            : isTrack
                                                ? "tracks"
                                                : "albums"
                                        }${isPlaylist
                                            ? "/" + content.id
                                            : "?id=" + content.id
                                        }`}
                                    className="card-title"
                                >
                                    {content.title}
                                </Link>
                                {isPlaylist ? (
                                    <div className="card-artist no-hover">
                                        <span>제작자 : </span>
                                        <Link
                                            to={`/users/${content.userId}`}
                                            className="card-artist"
                                        >
                                            {content.maker}
                                        </Link>
                                    </div>
                                ) : (
                                    <Link
                                        to={`/artists?id=${content.artistId}`}
                                        className="card-artist"
                                    >
                                        {content.artistName}
                                    </Link>
                                )}
                                {isPlaylist && (
                                    <div className="card-artist no-hover">
                                        ♥ {content.likeCount?.toLocaleString() ?? 0}
                                    </div>
                                )}
                            </div>
                            {!isPlaylist && (
                                <div className="d-flex justify-content-center mb-4">
                                    {content.avgRating != null ? (
                                        <canvas
                                            className="doughnut-canvas"
                                            data-rating={content.avgRating}
                                            width={50}
                                            height={50}
                                            data-chartid={`${isPlaylist
                                                    ? "playlist"
                                                    : isTrack
                                                        ? "track"
                                                        : "album"
                                                }-${content.id}`}
                                        ></canvas>
                                    ) : (
                                        <span className="no-rating fw-bold fs-2 pb-3">
                                            NR
                                        </span>
                                    )}
                                </div>
                            )}
                        </div>
                    </div>
                ))}
            </div>
            {count > 12 && (
                <div
                    className="d-flex flex-row align-items-center justify-content-end px-4 mb-3"
                    style={{ height: 50 }}
                >
                    <Link to={moreLink} className="more-link">
                        더 보기 &gt;
                    </Link>
                </div>
            )}
        </section>
    );
}
