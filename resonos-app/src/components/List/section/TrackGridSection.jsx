import { Link } from "react-router-dom";
import Pagination from "../../Pagination/Pagination";

export default function TrackGridSection({
    title,
    trackList,
    pagination,
    onPageChange
}) {
    return (
        <section className="main-section-bg w-100 py-4 mb-5">
            <div className="d-flex flex-row align-items-center px-4 mb-3" style={{ height: 50 }}>
                <div className="section-title flex-grow-1">{title}</div>
            </div>
            <div className="album-grid row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-6 g-0 m-0 justify-content-start">
                {trackList.map((track) => (
                    <div key={track.id} className="col d-flex justify-content-center">
                        <div className={'card align-items-center gap-2 mt-3'} style={{ width: 228, height: 340 }}>
                            <Link to={'/tracks?id=' + track.id}>
                                <img src={track.coverImage} className="card-img-top" alt="앨범커버" />
                            </Link>
                            <div className="card-body d-flex flex-column align-items-center">
                                <Link to={'/tracks?id=' + track.id} className="card-title">
                                    {track.title}
                                </Link>
                                <Link to={'/artists?id=' + track.artistId} className="card-artist">
                                    {track.artistName}
                                </Link>
                            </div>
                            <div className="d-flex justify-content-center mb-4">
                                {track.avgRating != null ? (
                                    <canvas
                                        className="doughnut-canvas"
                                        data-rating={track.avgRating}
                                        width={50}
                                        height={50}
                                        data-chartid={`${'track'}-${track.id}`}
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