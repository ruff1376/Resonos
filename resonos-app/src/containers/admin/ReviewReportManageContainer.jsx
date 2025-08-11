import React, { useEffect, useState } from "react";
import {
  getReviewList,
  setReviewBlind,
  deleteReview,
} from "../../apis/admin"; // api 유틸 import
import TableColumnHeader from "../../components/admin/first/TableColumnHeader";
import Pagination from "../../components/admin/Pagination";
import styles from "../../components/admin/css/admin.module.css";

const ReviewReportManageContainer = () => {
  const [type, setType] = useState("album"); // 'album' or 'track'
  const [reviews, setReviews] = useState([]);
  const [loading, setLoading] = useState(false);

  // 페이지네이션 상태
  const [page, setPage] = useState(1);
  const [pagination, setPagination] = useState({
    page: 1,
    totalPages: 1,
    total: 0,
    size: 10,
  });

  // 상세 보기 상태 (index : boolean)
  const [showDetail, setShowDetail] = useState({});

  const fetchReviews = async (t = type, pageNum = page, size = 10) => {
    setLoading(true);
    try {
      const res = await getReviewList(t, pageNum, size);
      setReviews(res.data.reviews || []);
      const p = res.data.pagination || {};
      const totalPages = p.size && p.total ? Math.ceil(p.total / p.size) : 1;
      setPagination({
        page: p.page || pageNum,
        totalPages,
        total: p.total || 0,
        size: p.size || size,
      });
      setType(t);
    } catch (err) {
      console.error("리뷰 목록 조회 실패", err);
      setReviews([]);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchReviews(type, page, pagination.size);
  }, [type, page]);

  const handleBlindToggle = async (reviewId, blinded) => {
    if (!window.confirm(blinded ? "블라인드 해제하시겠습니까?" : "블라인드 처리하시겠습니까?")) return;
    try {
      await setReviewBlind(type, reviewId, !blinded);
      fetchReviews(type, page, pagination.size);
    } catch (err) {
      console.error("블라인드 처리 실패", err);
    }
  };

  const handleDelete = async (reviewId) => {
    if (!window.confirm("정말 삭제하시겠습니까?")) return;
    try {
      await deleteReview(type, reviewId);
      fetchReviews(type, page, pagination.size);
    } catch (err) {
      console.error("리뷰 삭제 실패", err);
    }
  };

  const toggleDetail = (idx) => {
    setShowDetail((prev) => ({ ...prev, [idx]: !prev[idx] }));
  };

  const columns = [
    { label: "ID", style: { flexBasis: "8%", minWidth: "60px" } },
    { label: "작성자", style: { flexBasis: "12%", minWidth: "80px" } },
    { label: "대상ID", style: { flexBasis: "10%", minWidth: "80px" } },
    { label: "리뷰 내용", style: { flexBasis: "20%", minWidth: "120px" } },
    { label: "평점", style: { flexBasis: "8%", minWidth: "60px" } },
    { label: "블라인드", style: { flexBasis: "8%", minWidth: "60px" } },
    { label: "좋아요", style: { flexBasis: "8%", minWidth: "60px" } },
    { label: "싫어요", style: { flexBasis: "8%", minWidth: "60px" } },
    { label: "관리", style: { flexBasis: "10%", minWidth: "80px" } },
  ];

  return (
    <main className="py-5 bg-resonos-dark">
      <div className="container" style={{ maxWidth: 1200 }}>
        <h2 className="mb-4 text-light-gold">리뷰 신고 관리</h2>

        {/* 탭 */}
        <ul className="nav nav-tabs mb-4">
          <li className="nav-item">
            <button
              className={`nav-link ${type === "album" ? "active" : ""}`}
              onClick={() => {
                setPage(1);
                setType("album");
              }}
            >
              앨범 리뷰
            </button>
          </li>
          <li className="nav-item">
            <button
              className={`nav-link ${type === "track" ? "active" : ""}`}
              onClick={() => {
                setPage(1);
                setType("track");
              }}
            >
              트랙 리뷰
            </button>
          </li>
        </ul>

        {loading ? (
          <div>로딩중...</div>
        ) : (
          <div className="resonos-card p-3">
            <TableColumnHeader columns={columns} />
            <div>
              {reviews.length > 0 ? (
                reviews.map((review, idx) => (
                  <React.Fragment key={review.id}>
                    <div
                      className="list-group-item bg-dark text-light border-secondary mb-0 rounded-top d-flex flex-nowrap align-items-center text-center justify-content-center"
                    >
                      <div style={columns[0].style}>{review.id}</div>
                      <div style={columns[1].style}>
                        {review.reviewer?.nickname || review.userId}
                      </div>
                      <div style={columns[2].style}>
                        {type === "album" ? review.albumId : review.trackId}
                      </div>
                      <div style={columns[3].style}>{review.content}</div>
                      <div style={columns[4].style}>{review.rating}</div>
                      <div style={columns[5].style}>
                        {review.blinded ? "Y" : "N"}
                      </div>
                      <div style={columns[6].style}>{review.likes}</div>
                      <div style={columns[7].style}>{review.dislikes}</div>
                      <div style={columns[8].style}>
                        <button
                          className="btn btn-outline-gold btn-sm me-1"
                          onClick={() => toggleDetail(idx)}
                        >
                          상세
                        </button>
                        <button
                          className="btn btn-outline-danger btn-sm me-1"
                          onClick={() => handleBlindToggle(review.id, review.blinded)}
                        >
                          {review.blinded ? "블라인드 해제" : "블라인드"}
                        </button>
                        <button
                          className="btn btn-outline-danger btn-sm"
                          onClick={() => handleDelete(review.id)}
                        >
                          삭제
                        </button>
                      </div>
                    </div>

                    {/* 상세 영역 */}
                    {showDetail[idx] && (
                    <div className="detail-row border-secondary mb-2" style={{ display: "block" }}>
                        <div className="container" style={{ maxWidth: 900 }}>
                        <h4 className="mb-3 text-light-gold">리뷰 상세</h4>
                        <table className="table table-dark table-bordered align-middle">
                            <tbody>
                            <tr><th>ID</th><td>{review.id}</td></tr>
                            <tr>
                                <th>작성자</th>
                                <td>{review.reviewer?.nickname || review.userId}</td>
                            </tr>

                            {type === "album" && (
                                <tr>
                                <th>앨범ID</th>
                                <td>
                                    {review.albumId}
                                    <a
                                    href={`/albums?id=${review.albumId}`}
                                    className="btn btn-outline-info btn-sm ms-2"
                                    target="_blank"
                                    rel="noopener noreferrer"
                                    >
                                    앨범 상세로 이동
                                    </a>
                                </td>
                                </tr>
                            )}

                            {type === "track" && (
                                <tr>
                                <th>트랙ID</th>
                                <td>
                                    {review.trackId}
                                    <a
                                    href={`/tracks?id=${review.trackId}`}
                                    className="btn btn-outline-info btn-sm ms-2"
                                    target="_blank"
                                    rel="noopener noreferrer"
                                    >
                                    트랙 상세로 이동
                                    </a>
                                </td>
                                </tr>
                            )}

                            <tr><th>평점</th><td>{review.rating}</td></tr>
                            <tr><th>리뷰 내용</th><td>{review.content}</td></tr>
                            <tr><th>블라인드</th><td>{review.blinded ? "Y" : "N"}</td></tr>
                            <tr><th>좋아요</th><td>{review.likes}</td></tr>
                            <tr><th>싫어요</th><td>{review.dislikes}</td></tr>
                            <tr><th>작성일시</th><td>{review.createdAt}</td></tr>
                            </tbody>
                        </table>
                        </div>
                    </div>
                    )}

                  </React.Fragment>
                ))
              ) : (
                <div className="list-group-item text-center text-secondary bg-dark">
                  리뷰가 없습니다.
                </div>
              )}
            </div>

            {/* 페이지네이션 */}
            {pagination.totalPages > 1 && (
              <Pagination
                page={pagination.page}
                first={1}
                last={pagination.totalPages}
                prev={pagination.page > 1 ? pagination.page - 1 : 1}
                next={
                  pagination.page < pagination.totalPages
                    ? pagination.page + 1
                    : pagination.totalPages
                }
                start={Math.max(1, (pagination.page || 1) - 4)}
                end={Math.min(pagination.totalPages, (pagination.page || 1) + 5)}
                pageUri={`/admin/report/review?type=${type}`}
                onPageChange={(newPage) => setPage(newPage)}
              />
            )}
          </div>
        )}
      </div>
    </main>
  );
};

export default ReviewReportManageContainer;
