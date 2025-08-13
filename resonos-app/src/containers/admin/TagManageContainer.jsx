import React, { useEffect, useState } from "react";
import {
  listTags,
  addTag,
  updateTag,
  deleteTag,
  searchTags,
} from "../../apis/admin"; // tag API 유틸
import TableColumnHeader from "../../components/admin/first/TableColumnHeader";
import SearchForm from "../../components/admin/first/SearchForm";
import Pagination from "../../components/admin/Pagination";
import FormInput from "../../components/admin/first/FormInput";

const TagManageContainer = () => {
  const [tags, setTags] = useState([]);
  const [pagination, setPagination] = useState({});
  const [keyword, setKeyword] = useState("");
  const [loading, setLoading] = useState(false);

  const [newTag, setNewTag] = useState("");
  const [editTagId, setEditTagId] = useState(null);
  const [editName, setEditName] = useState("");

  // 목록 조회
const fetchData = async (page = 1, size = 10, kw = "") => {
  setLoading(true);
  try {
    const res = await listTags(page, size, kw);
    setTags(res.data.tags || []);

    const p = res.data.pagination || {};
    const totalPages = p.size && p.total ? Math.ceil(p.total / p.size) : 1;

    setPagination({
      ...p,
      totalPages
    });
  } catch (err) {
    console.error("태그 목록 조회 실패:", err);
  } finally {
    setLoading(false);
  }
};


  useEffect(() => {
    fetchData(1, 10, keyword);
  }, [keyword]);

  // 등록
  const handleAdd = async (e) => {
    e.preventDefault();
    if (!newTag.trim()) return;
    try {
      await addTag({ name: newTag });
      setNewTag("");
      fetchData(1, 10, keyword);
    } catch (err) {
      console.error("등록 실패", err);
    }
  };

  // 수정
  const handleUpdate = async (id) => {
    if (!editName.trim()) return;
    try {
      await updateTag(id, { name: editName });
      setEditTagId(null);
      setEditName("");
      fetchData(pagination.page || 1, pagination.size || 10, keyword);
    } catch (err) {
      console.error("수정 실패", err);
    }
  };

  // 삭제
  const handleDelete = async (id) => {
    if (!window.confirm("정말 삭제하시겠습니까?")) return;
    try {
      await deleteTag(id);
      fetchData(pagination.page || 1, pagination.size || 10, keyword);
    } catch (err) {
      console.error("삭제 실패", err);
    }
  };

  // 검색
  const handleSearch = async (kw) => {
    setKeyword(kw);
    if (!kw.trim()) {
      fetchData();
      return;
    }
    try {
      const res = await searchTags(kw);
      setTags(res.data.tags || []);
    } catch (err) {
      console.error("검색 실패", err);
    }
  };

  // 페이지 이동
  const onPageChange = (newPage) => {
    if (newPage === pagination.page) return;
    fetchData(newPage, pagination.size || 10, keyword);
  };
  

  const columns = [
    { label: "ID", style: { flexBasis: "12%", minWidth: "60px" } },
    { label: "이름", style: { flexBasis: "50%", minWidth: "120px" } },
    { label: "수정", style: { flexBasis: "18%", minWidth: "80px" } },
    { label: "삭제", style: { flexBasis: "20%", minWidth: "80px" } },
  ];

  return (
    <div className="container py-4" style={{ maxWidth: 950 }}>
      <h2 className="mb-3 text-light-gold">태그/분위기 관리</h2>
      <div className="resonos-card p-4">
        <h3 className="mb-3 text-light-gold">등록 및 검색</h3>
        <div className="d-flex justify-content-between mb-2">
          {/* 등록 폼 */}
          <form onSubmit={handleAdd} className="d-flex gap-2">
            <FormInput
              name="name"
              value={newTag}
              onChange={(e) => setNewTag(e.target.value)}
              placeholder="새 태그/분위기명"
              required
              maxLength={50}
              containerClassName=""
              className="api-key-input"
            />
            <button className="btn btn-gold btn-sm">등록</button>
          </form>
          {/* 검색폼 */}
          <SearchForm
            initialKeyword={keyword}
            placeholder="태그/분위기명 검색"
            buttonLabel="검색"
            onSearch={handleSearch}
          />
        </div>

        <div className="resonos-card p-3">
          <TableColumnHeader columns={columns} />
          {loading ? (
            <div className="p-3">로딩중...</div>
          ) : tags.length > 0 ? (
            tags.map((tag) => (
              <div
                key={tag.id}
                className="list-group-item bg-dark text-light border-secondary mb-2 d-flex text-center"
              >
                <div style={columns[0].style}>{tag.id}</div>
                <div style={columns[1].style}>
                  {editTagId === tag.id ? (
                    <FormInput
                      name="editName"
                      value={editName}
                      onChange={(e) => setEditName(e.target.value)}
                      required
                      maxLength={50}
                      containerClassName=""
                      className="form-control"
                    />
                  ) : (
                    tag.name
                  )}
                </div>
                <div style={columns[2].style}>
                  {editTagId === tag.id ? (
                    <button
                      className="btn btn-gold btn-xs"
                      onClick={() => handleUpdate(tag.id)}
                    >
                      저장
                    </button>
                  ) : (
                    <button
                      className="btn btn-outline-gold btn-xs"
                      onClick={() => {
                        setEditTagId(tag.id);
                        setEditName(tag.name);
                      }}
                    >
                      수정
                    </button>
                  )}
                </div>
                <div style={columns[3].style}>
                  <button
                    className="btn btn-outline-gold btn-xs"
                    onClick={() => handleDelete(tag.id)}
                  >
                    삭제
                  </button>
                </div>
              </div>
            ))
          ) : (
            <div className="text-center text-secondary p-3">
              등록된 태그/분위기가 없습니다.
            </div>
          )}
        </div>

        {/* 페이지네이션 */}
        {pagination.totalPages > 1 && (
          <Pagination
            page={pagination.page || 1}
            first={1}
            last={pagination.totalPages || 1}
            prev={pagination.page > 1 ? pagination.page - 1 : 1}
            next={
              pagination.page < pagination.totalPages
                ? pagination.page + 1
                : pagination.totalPages || 1
            }
            start={Math.max(1, (pagination.page || 1) - 4)}
            end={Math.min(
              pagination.totalPages || 1,
              (pagination.page || 1) + 5
            )}
            pageUri={`/admin/tags?keyword=${encodeURIComponent(keyword)}`}
            onPageChange={onPageChange}
          />
        )}
      </div>
    </div>
  );
};

export default TagManageContainer;
