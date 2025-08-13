import { Link } from "react-router-dom";
import Pagination from "../../Pagination/Pagination";

export default function PlaylistGridSection({
    title,
    playlistList,
    pagination,
    onPageChange
}) {
    return (
        <section className="main-section-bg w-100 py-4 mb-5">
            <div className="d-flex flex-row align-items-center px-4 mb-3" style={{ height: 50 }}>
                <div className="section-title flex-grow-1">{title}</div>
            </div>
            <div className="album-grid row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-6 g-0 m-0 justify-content-start" style={{ rowGap: "4rem", padding: "50px 0" }}>
                {playlistList.map((playlist) => (
                    <div key={playlist.id} className="col d-flex justify-content-center">
                        <div className={'card align-items-center gap-2 mt-3'} style={{ width: 228, height: 240 }}>
                            <Link to={'/playlists/' + playlist.id}>
                                <img src={playlist.thumbnailUrl} className="card-img-top" alt="썸네일" />
                            </Link>
                            <div className="card-body d-flex flex-column align-items-center">
                                <Link to={'/playlists/' + playlist.id} className="card-title">
                                    {playlist.title}
                                </Link>
                                <div className="card-artist no-hover">
                                    <span>제작자 : </span>
                                    <Link to={'/users/' + playlist.maker} className="card-artist">
                                        {playlist.maker}
                                    </Link>
                                </div>
                                <div className="card-artist no-hover">♥ {playlist.likeCount?.toLocaleString() ?? 0}</div>
                            </div>
                        </div>
                    </div>
                ))}
            </div>
            <Pagination pagination={pagination} onPageChange={onPageChange} />
        </section>
    );
}