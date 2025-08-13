import { Link } from "react-router-dom";
import Pagination from "../../Pagination/Pagination";

export default function UserSearchGridSection({
    keyword,
    userSearchList,
    userSearchCount,
    pagination,
    onPageChange,
    showPagination = false
}) {

    const formatNumber = (num) => num?.toLocaleString("ko-KR") || "0";

    const showMoreButton = !showPagination && userSearchCount > 6;

    return (
        <section className="main-section-bg w-100 py-4 mb-5">
            <div
                className="d-flex flex-row align-items-center px-4 mb-3"
                style={{ height: 50 }}
            >
                <div className="section-title flex-grow-1">회원</div>
            </div>
            {!userSearchList || userSearchList.length === 0 ? (
                <div
                    style={{
                        borderTop: "1px solid #D4B97F",
                        borderBottom: "1px solid #D4B97F",
                        padding: "40px 0",
                    }}
                >
                    <div className="d-flex justify-content-center align-items-center">
                        <h3 style={{ color: "#B1B1B1" }}>검색된 회원이 없습니다.</h3>
                    </div>
                </div>
            ) : (
                <div className="album-grid row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-6 g-0 m-0 justify-content-start" style={{ rowGap: "3rem" }}>
                    {userSearchList.map((user) => (
                        <div className="col d-flex justify-content-center" key={user.id}>
                            <div
                                className="card align-items-center p-3"
                                style={{ width: 228, height: 230 }}
                            >
                                <Link to={`/users/${user.id}`}>
                                    <img
                                        src={user.profileImage}
                                        className="card-img-top rounded-circle"
                                        alt="프로필 이미지"
                                    />
                                </Link>
                                <div className="card-body">
                                    <Link to={`/users/${user.id}`} className="card-title">
                                        {user.nickname}
                                    </Link>
                                    <div className="card-artist no-hover">
                                        {formatNumber(user.followerCount)} 팔로워
                                    </div>
                                </div>
                            </div>
                        </div>
                    ))}
                </div>
            )}
            {showMoreButton && (
                <div className="d-flex flex-row align-items-center justify-content-end px-4 mb-3" style={{ height: 50 }}>
                    <Link to={`/search/users?q=${keyword}`} className="more-link">
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