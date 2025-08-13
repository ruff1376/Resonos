import React, { useState, useEffect } from "react";
import { getNotifications, createNotification } from "../../apis/admin"; // API 유틸
import Pagination from "../../components/admin/Pagination";
import SearchForm from "../../components/admin/first/SearchForm";
import TableColumnHeader from "../../components/admin/first/TableColumnHeader";
import QuickMenu from "../../components/admin/first/QuickMenu";

const AdminNotificationContainer = () => {
  // 상태
  const [notifications, setNotifications] = useState([]);
  const [pagination, setPagination] = useState({
    page: 1,
    totalPages: 1,
    total: 0,
    size: 10
  });
  const [keyword, setKeyword] = useState("");
  const [page, setPage] = useState(1);
  const [size] = useState(10);
  const [errorMessage, setErrorMessage] = useState("");
  const [formData, setFormData] = useState({
    userId: "",
    type: "system",
    message: "",
    content: "",
    targetId: "",
  });

  // 컬럼 정의
  const columns = [
    { label: "ID",           style: { flexBasis: "6%",  minWidth: "50px" } },
    { label: "회원ID",       style: { flexBasis: "8%",  minWidth: "60px" } },
    { label: "종류",         style: { flexBasis: "10%", minWidth: "70px" } },
    { label: "제목",         style: { flexBasis: "15%", minWidth: "120px" } },
    { label: "내용",         style: { flexBasis: "25%", minWidth: "200px" } },
    { label: "연결ID",       style: { flexBasis: "8%",  minWidth: "60px" } },
    { label: "읽음",         style: { flexBasis: "8%",  minWidth: "60px" } },
    { label: "등록일",       style: { flexBasis: "20%", minWidth: "150px" } },
  ];

  // 데이터 로드
  const fetchNotifications = async (pg = page, kw = keyword) => {
    try {
      const res = await getNotifications(pg, size, kw);
      if (res.data.success) {
        setNotifications(res.data.notifications);
        setPagination(res.data.pagination);
        setKeyword(res.data.keyword || "");
        setErrorMessage("");
      } else {
        setErrorMessage(res.data.message || "목록 조회 실패");
      }
    } catch (error) {
      console.error("목록 조회 오류:", error);
      setErrorMessage("알림 목록을 불러오는데 실패했습니다.");
    }
  };

  useEffect(() => {
    fetchNotifications();
  }, [page]);

  // 입력 변경
  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setFormData((prev) => ({ ...prev, [name]: value }));
  };

  // 알림 등록
  const handleCreateNotification = async (e) => {
    e.preventDefault();
    try {
      const res = await createNotification(formData);
      if (res.data.success) {
        alert(res.data.message);
        setFormData({ userId: "", type: "system", message: "", content: "", targetId: "" });
        setPage(1);
        fetchNotifications(1);
      } else {
        setErrorMessage(res.data.message || "등록 실패");
      }
    } catch (error) {
      console.error("등록 오류:", error);
      setErrorMessage("등록 중 오류가 발생했습니다.");
    }
  };

  // 검색 실행
  const handleSearch = (kw) => {
    setKeyword(kw);
    setPage(1);
    fetchNotifications(1, kw);
  };

  // 페이지 변경
  const handlePageChange = (newPage) => {
    if (newPage === page) return;
    setPage(newPage);
  };

return (
  <div className="admin bg-dark text-light">
    <main className="py-5 bg-resonos-dark">
      <div className="container admin-container max-w-1100">
        <h2 className="mb-4 text-light-gold">알림 관리</h2>

        {errorMessage && (
          <div className="alert alert-danger">{errorMessage}</div>
        )}

        {/* 알림 등록 폼 */}
        <section className="resonos-card p-4 mb-5">
          <h4 className="mb-3">새 알림 등록</h4>
          <form onSubmit={handleCreateNotification} className="row g-3">
            <div className="col-md-3">
              <label htmlFor="userId" className="form-label">수신자 회원ID</label>
              <input
                type="number"
                name="userId"
                className="form-control"
                value={formData.userId}
                onChange={handleInputChange}
              />
            </div>
            <div className="col-md-3">
              <label htmlFor="type" className="form-label">종류</label>
              <select
                name="type"
                className="form-select"
                value={formData.type}
                onChange={handleInputChange}
              >
                <option value="system">시스템 알림</option>
                <option value="push">푸시 알림</option>
                <option value="announcement">공지</option>
              </select>
            </div>
            <div className="col-md-6">
              <label htmlFor="message" className="form-label">제목 (Message)</label>
              <input
                type="text"
                name="message"
                className="form-control"
                value={formData.message}
                onChange={handleInputChange}
                required
              />
            </div>
            <div className="col-md-12">
              <label htmlFor="content" className="form-label">상세 내용</label>
              <textarea
                name="content"
                className="form-control"
                rows="3"
                value={formData.content}
                onChange={handleInputChange}
                required
              />
            </div>
            <div className="col-md-6">
              <label htmlFor="targetId" className="form-label">연결 대상 ID (선택)</label>
              <input
                type="text"
                name="targetId"
                className="form-control"
                value={formData.targetId}
                onChange={handleInputChange}
              />
            </div>
            <div className="col-md-6 d-flex align-items-end justify-content-end">
              <button type="submit" className="btn btn-gold">등록 및 발송</button>
            </div>
          </form>
        </section>

        {/* 검색 */}
        <SearchForm
          initialKeyword={keyword}
          placeholder="제목/내용 검색"
          onSearch={handleSearch}
        />

        {/* 리스트 */}
        <section className="resonos-card p-3">
          <TableColumnHeader columns={columns} />
          {notifications.length > 0 ? (
            notifications.map((noti) => (
              <div
                key={noti.id}
                className="list-group-item bg-dark text-light border-secondary mb-2 d-flex flex-nowrap align-items-center text-center"
              >
                <div className="table-col">{noti.id}</div>
                <div className="table-col">{noti.userId}</div>
                <div className="table-col">{noti.type}</div>
                <div className="table-col">{noti.message}</div>
                <div className="table-col">{noti.content}</div>
                <div className="table-col">{noti.targetId || "-"}</div>
                <div className="table-col">{noti.isRead ? "읽음" : "읽지 않음"}</div>
                <div className="table-col">
                  {new Date(noti.createdAt).toLocaleString("ko-KR", {
                    year: "numeric",
                    month: "2-digit",
                    day: "2-digit",
                    hour: "2-digit",
                    minute: "2-digit",
                  })}
                </div>
              </div>
            ))
          ) : (
            <div className="list-group-item text-center text-secondary bg-dark">
              등록된 알림이 없습니다.
            </div>
          )}

          {/* 페이지네이션 */}
          {pagination.totalPages > 1 && (
            <Pagination
              page={pagination.page}
              first={1}
              last={pagination.totalPages}
              prev={pagination.page > 1 ? pagination.page - 1 : 1}
              next={pagination.page < pagination.totalPages ? pagination.page + 1 : pagination.totalPages}
              start={Math.max(1, (pagination.page || 1) - 4)}
              end={Math.min(pagination.totalPages, (pagination.page || 1) + 5)}
              pageUri={`/admin/notifications?keyword=${encodeURIComponent(keyword)}`}
              onPageChange={handlePageChange}
            />
          )}
        </section>
      </div>
    </main>
    <QuickMenu />
  </div>
);




};

export default AdminNotificationContainer;
