import {
    Chart,
    DoughnutController,
    ArcElement,
    Tooltip,
    Legend
} from 'chart.js';
Chart.register(DoughnutController, ArcElement, Tooltip, Legend);
import 'bootstrap/dist/css/bootstrap.min.css';
import './MainForm.css'
import Pagination from '../Pagination/Pagination';

const chartInstances = new Map();

export default function HotPlaylistForm({
    hotPlaylistList = [],
    hotPlaylistCount = 0,
    pagination = [],
    onPageChange = () => {}
}) {
    return (
        <div className="container-fluid d-flex flex-column align-items-center px-0" style={{ maxWidth: 1440, paddingTop: 50, gap: 50 }}>
            <GridSection
                title="인기 플레이리스트"
                hotPlaylistList={hotPlaylistList}
                count={hotPlaylistCount}
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

function GridSection({ title, hotPlaylistList, pagination, onPageChange}) {
    return (
        <section className="main-section-bg w-100 py-4 mb-5">
            <div className="d-flex flex-row align-items-center px-4 mb-3" style={{ height: 50 }}>
                <div className="section-title flex-grow-1">{title}</div>
            </div>
            <div className="album-grid row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-6 g-0 m-0 justify-content-start">
                {hotPlaylistList.map((playlist) => (
                    <div key={playlist.id} className="col d-flex justify-content-center">
                        <div className={'card align-items-center gap-2 mt-3'} style={{ width: 228, height: 240 }}>
                            <a href={'/playlists/' + playlist.id}>
                                <img src={playlist.thumbnailUrl} className="card-img-top" alt="썸네일" />
                            </a>
                            <div className="card-body d-flex flex-column align-items-center">
                                <a href={'/playlists/' + playlist.id} className="card-title">
                                    {playlist.title}
                                </a>
                                <a href={'/artists?id=' + playlist.artistId} className="card-artist">
                                    {playlist.maker}
                                </a>
                                <div className="card-artist">♥ {playlist.likeCount?.toLocaleString() ?? 0}</div>
                            </div>
                        </div>
                    </div>
                ))}
            </div>
            <Pagination pagination={pagination} onPageChange={onPageChange} />
        </section>
    );
}
