import React, { useEffect, useState } from "react";
import { listNotices, saveNotice, deleteNotice } from "../../apis/admin";
import SearchForm from "../../components/admin/first/SearchForm";
import TableColumnHeader from "../../components/admin/first/TableColumnHeader";
import TableContentGeneric from "../../components/admin/first/TableContentGeneric";
import Pagination from "../../components/admin/Pagination";
import FormInput from "../../components/admin/first/FormInput";
import FormSelect from "../../components/admin/first/FormSelect";


const initialForm = {
  id: null,
  title: "",
  content: "",
  isActive: true,
  startAt: "",
  endAt: ""
};

const AdminNoticeContainer = () => {
  const [notices, setNotices] = useState([]);
  const [formData, setFormData] = useState(initialForm);
  const [loading, setLoading] = useState(false);
  const [pagination, setPagination] = useState({ page: 1, size: 10, totalPages: 1 });
  const [keyword, setKeyword] = useState("");

const fetchNotices = async (page = 1, size = 10, kw = keyword) => {
  setLoading(true);
  try {
    const res = await listNotices(page, size, kw);
    const data = res.data;
    setNotices(data.notices || []);
    if (data.pagination) {
      setPagination({
        page: data.pagination.page,
        size: data.pagination.size,
        total: data.pagination.total,
        totalPages: data.pagination.totalPages
      });
    }
  } finally {
    setLoading(false);
  }
};


  useEffect(() => {
    fetchNotices(1, pagination.size, keyword);
  }, [keyword]);

  const handleChange = e => {
    const { name, value } = e.target;
    setFormData(prev => ({
      ...prev,
      [name]: name === "isActive" ? value === "true" : value
    }));
  };

  const handleSubmit = async e => {
    e.preventDefault();
    const res = await saveNotice(formData);
    if (res.data.success) {
      alert("저장 완료");
      setFormData(initialForm);
      fetchNotices(pagination.page, pagination.size, keyword);
    }
  };

  const handleDelete = async id => {
    if (!window.confirm("삭제하시겠습니까?")) return;
    const res = await deleteNotice(id);
    if (res.data.success) {
      alert("삭제 완료");
      fetchNotices(pagination.page, pagination.size, keyword);
    }
  };

  const handleEdit = n => {
    setFormData({
      ...n,
      startAt: n.startAt?.slice(0, 10) || "",
      endAt: n.endAt?.slice(0, 10) || ""
    });
  };

  const onPageChange = newPage => {
    fetchNotices(newPage, pagination.size, keyword);
  };

  // 📌 columns 재사용: TableContentGeneric 용
  const columns = [
    { label: "#", style: { flexBasis: "5%" }, render: (_, idx) => (pagination.page - 1) * pagination.size + idx + 1 },
    { label: "제목", style: { flexBasis: "20%" }, render: n => n.title },
    { label: "작성일", style: { flexBasis: "20%" }, render: n => n.createdAt?.slice(0, 16) },
    { label: "상태", style: { flexBasis: "10%" }, render: n => <span className={n.isActive ? "text-success" : "text-secondary"}>{n.isActive ? "활성" : "비활성"}</span> },
    { label: "시작일", style: { flexBasis: "15%" }, render: n => n.startAt?.slice(0, 10) || "-" },
    { label: "종료일", style: { flexBasis: "15%" }, render: n => n.endAt?.slice(0, 10) || "-" },
    {
      label: "관리", style: { flexBasis: "15%" }, render: n => (
        <>
          <button className="btn btn-outline-gold btn-sm me-1" onClick={() => handleEdit(n)}>수정</button>
          <button className="btn btn-outline-danger btn-sm" onClick={() => handleDelete(n.id)}>삭제</button>
        </>
      )
    }
  ];

  return (
    <main className="py-5 bg-resonos-dark" style={{ minHeight: "80vh" }}>
      <div className="container" style={{ maxWidth: 1200 }}>
        <h2 className="mb-4 text-light-gold fw-bold">공지 관리</h2>

        <div className="mb-3">
          <SearchForm initialKeyword={keyword} placeholder="제목 검색" onSearch={setKeyword} />
        </div>

        <div className="row gx-4">
          {/* 📢 목록 */}
          <div className="col-md-6">
            <div className="resonos-card p-3 bg-secondary bg-opacity-10 rounded-3" style={{ maxHeight: "70vh", overflowY: "auto" }}>
              {loading ? <div>로딩중...</div> : (
                <>
                  <TableColumnHeader columns={columns} />
                  <TableContentGeneric items={notices} columns={columns} pagination={pagination} />
                  {pagination.totalPages > 1 && (
                    <Pagination
                      page={pagination.page}
                      first={1}
                      last={pagination.totalPages}
                      prev={pagination.page > 1 ? pagination.page - 1 : 1}
                      next={pagination.page < pagination.totalPages ? pagination.page + 1 : pagination.totalPages}
                      start={Math.max(1, pagination.page - 4)}
                      end={Math.min(pagination.totalPages, pagination.page + 5)}
                      pageUri={`/admin/notices?keyword=${encodeURIComponent(keyword)}`}
                      onPageChange={onPageChange}
                    />
                  )}
                </>
              )}
            </div>
          </div>

          {/* 📝 폼 */}
            <div className="col-md-6">
                <div className="resonos-card p-4 bg-secondary bg-opacity-10 rounded-3">
                    <h4>{formData.id ? "공지 수정" : "공지 등록"}</h4>
                    <form onSubmit={handleSubmit} className="row g-2">
                    <input type="hidden" id="id" name="id" value={formData.id || ""} />

                    <FormInput
                        label="제목"
                        name="title"
                        value={formData.title}
                        onChange={handleChange}
                        required
                        containerClassName="col-12"
                    />

                    <div className="col-12">
                        <label className="form-label" htmlFor="content">내용</label>
                        <textarea
                        id="content"
                        name="content"
                        value={formData.content}
                        onChange={handleChange}
                        className="form-control"
                        rows="5"
                        required
                        />
                    </div>

                    <FormSelect
                        label="활성 여부"
                        name="isActive"
                        value={formData.isActive}
                        onChange={handleChange}
                        options={[
                        { value: "true", label: "활성" },
                        { value: "false", label: "비활성" }
                        ]}
                        containerClassName="col-12"
                    />

                    <FormInput
                        label="시작일"
                        type="date"
                        name="startAt"
                        value={formData.startAt}
                        onChange={handleChange}
                        containerClassName="col-md-6"
                    />

                    <FormInput
                        label="종료일"
                        type="date"
                        name="endAt"
                        value={formData.endAt}
                        onChange={handleChange}
                        containerClassName="col-md-6"
                    />

                    <div className="col-12 text-end">
                        <button type="submit" className="btn btn-gold me-2">저장</button>
                        <button
                        type="button"
                        className="btn btn-secondary"
                        onClick={() => setFormData(initialForm)}
                        >
                        초기화
                        </button>
                    </div>
                    </form>
                </div>
            </div>

        </div>
      </div>
    </main>
  );
};

export default AdminNoticeContainer;
