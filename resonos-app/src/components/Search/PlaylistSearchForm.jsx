import 'bootstrap/dist/css/bootstrap.min.css';
import '../List/MainForm.css'
import Pagination from '../Pagination/Pagination';

export default function PlaylistSearchForm({
    keyword,
    playlistSearchList = [],
    playlistSearchCount = 0,
    pagination = [],
    onPageChange = () => {},
}) {
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
                    검색 결과 : "<span>{keyword || "검색어"}</span>" (<span>{playlistSearchCount ?? 0}</span>건)
                </h1>
            </div>

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
                                            alt="썸네일"
                                        />
                                    </a>
                                    <div className="card-body d-flex flex-column align-items-center">
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
                <Pagination pagination={pagination} onPageChange={onPageChange} />
            </section>

            {/* 위로가기 플로팅 버튼 */}
            <div className="floating">
                <a href="#">
                    <i className="bi bi-caret-up-fill"></i>
                </a>
            </div>
        </div>
    );
}
