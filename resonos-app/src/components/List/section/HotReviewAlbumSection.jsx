import { Link } from "react-router-dom";

export default function HotReviewAlbumSection({ title, albumList }) {
    return (
        <div
            className="d-flex flex-column align-items-start justify-content-start p-0"
            style={{ width: "100%", margin: 50 }}
        >
            <div className="main-title py-3 px-4 w-100">{title}</div>
            <div
                className="d-flex flex-column justify-content-start gap-3 w-100"
                style={{ margin: "20px 10px" }}
            >
                {albumList.map((album, idx) => (
                    <Link
                        key={album.id}
                        to={`/albums?id=${album.id}`}
                        className={`album-card${idx === 0 ? "" : " secondary"
                            } d-flex flex-row align-items-center justify-content-between px-4 py-3 gap-4 w-100 position-relative`}
                    >
                        <div
                            className="d-flex align-items-center gap-4 flex-shrink-1"
                            style={{ minWidth: 0 }}
                        >
                            <div className={`album-rank ${idx === 0 ? "top" : ""}`}>
                                {idx + 1}
                            </div>
                            <img src={album.coverImage} alt="앨범커버" className="album-img" />
                            <div
                                className="d-flex flex-column justify-content-center"
                                style={{
                                    minWidth: 180,
                                    maxWidth: 400,
                                    overflow: "hidden",
                                }}
                            >
                                <div className="album-title">{album.title}</div>
                                <div className="album-artist">{album.artistName}</div>
                            </div>
                        </div>
                        <div
                            className="d-flex justify-content-end align-items-center me-4"
                            style={{ flexShrink: 0 }}
                        >
                            {album.avgRating != null ? (
                                <canvas
                                    className="doughnut-canvas"
                                    data-rating={album.avgRating}
                                    width={idx === 0 ? 75 : 50}
                                    height={idx === 0 ? 75 : 50}
                                    data-first={idx === 0 ? "true" : undefined}
                                    data-chartid={`album-${album.id}`}
                                ></canvas>
                            ) : (
                                <span className="no-rating me-4 fw-bold fs-2">NR</span>
                            )}
                        </div>
                    </Link>
                ))}
            </div>
        </div>
    );
}
