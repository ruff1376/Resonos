import 'bootstrap/dist/css/bootstrap.min.css';
import '../List/MainForm.css'
import Pagination from '../Pagination/Pagination';
import ScrollToTop from '../ScrollToTop/ScrollToTop';
import { Link } from 'react-router-dom';

export default function ArtistSearchForm({
    keyword,
    artistSearchList = [],
    artistSearchCount = 0,
    pagination = [],
    onPageChange = () => {}
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
                    검색 결과 : "<span>{keyword || "검색어"}</span>" (<span>{artistSearchCount ?? 0}</span>건)
                </h1>
            </div>

            <section className="main-section-bg w-100 py-4 mb-5">
                <div
                    className="d-flex flex-row align-items-center px-4 mb-3"
                    style={{ height: 50 }}
                >
                    <div className="section-title flex-grow-1">아티스트</div>
                </div>
                {!artistSearchList || artistSearchList.length === 0 ? (
                    <div
                        style={{
                            borderTop: "1px solid #D4B97F",
                            borderBottom: "1px solid #D4B97F",
                            padding: "40px 0",
                        }}
                    >
                        <div className="d-flex justify-content-center align-items-center">
                            <h3 style={{ color: "#B1B1B1" }}>검색된 아티스트가 없습니다.</h3>
                        </div>
                    </div>
                ) : (
                    <div className="album-grid row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-6 g-0 m-0 justify-content-start" style={{ rowGap: "3rem" }}>
                        {artistSearchList.map((artist) => (
                            <div className="col d-flex justify-content-center" key={artist.id}>
                                <div
                                    className="card align-items-center p-3"
                                    style={{ width: 228, height: 230 }}
                                >
                                    <Link to={`/artists?id=${artist.id}`}>
                                        <img
                                            src={artist.profileImage}
                                            className="card-img-top rounded-circle"
                                            alt="아티스트 이미지"
                                        />
                                    </Link>
                                    <div className="card-body">
                                        <Link to={`/artists?id=${artist.id}`} className="card-title">
                                            {artist.name}
                                        </Link>
                                        <div className="card-artist">
                                            {formatNumber(artist.followerCount)} 팔로워
                                        </div>
                                    </div>
                                </div>
                            </div>
                        ))}
                    </div>
                )}
                <Pagination pagination={pagination} onPageChange={onPageChange} />
            </section>

            <ScrollToTop />
        </div>
    );
}
