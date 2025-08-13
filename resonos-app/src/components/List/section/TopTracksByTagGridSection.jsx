import { Link } from "react-router-dom";

export default function TopTracksByTagGridSection({
    topTracksByTag = {},
    topTags = []
}) {
    
    if (!topTags || topTags.length === 0) return null;

    return (
        <section className="main-section-bg w-100 py-4 mb-5">
            <div
                className="d-flex flex-row align-items-center px-4 mb-3"
                style={{ height: 50 }}
            >
                <div className="section-title flex-grow-1">태그 별 인기 트랙</div>
            </div>

            {topTags.map((tag) => {

                const trackList = topTracksByTag[tag] || [];

                if (trackList.length === 0) return null;

                return trackList.map((track, idx) => {
                    return (
                        <div className="track-tag-grid">
                            <div className="track-tag-card" key={`${tag}-${track.id}`}>
                                <Link to={`/search?q=${encodeURIComponent('#' + tag)}`} className="tag">
                                    #{tag}
                                </Link>
                                <div className="track-card">
                                    <Link
                                        to={`/tracks?id=${track.id}`}
                                        className="album-card secondary d-flex flex-row align-items-center justify-content-between px-4 py-3 gap-4 w-100 position-relative"
                                    >
                                        <div
                                            className="d-flex align-items-center gap-4 flex-shrink-1"
                                            style={{ minWidth: 0 }}
                                        >
                                            <div className={`album-rank ${idx === 0 ? "top" : ""}`}>
                                                {idx + 1}
                                            </div>
                                            <img src={track.coverImage} alt="앨범커버" className="album-img" />
                                            <div
                                                className="d-flex flex-column justify-content-center"
                                                style={{
                                                    minWidth: 180,
                                                    maxWidth: 400,
                                                    overflow: "hidden",
                                                }}
                                            >
                                                <div className="album-title">{track.title}</div>
                                                <div className="album-artist">{track.artistName}</div>
                                            </div>
                                        </div>
                                    </Link>
                                </div>
                            </div>
                        </div>
                    );
                });
            })}
        </section>
    );
}