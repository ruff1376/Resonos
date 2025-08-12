import React, { useEffect, useState, useRef } from "react";
import {
  getQnaList,
  createQnaAnswer,
  updateQnaAnswer,
  deleteQnaAnswer,
  deleteQna
} from "../../apis/admin";
import TabsGeneric from "../../components/admin/first/TabsGeneric";
import TableColumnHeader from "../../components/admin/first/TableColumnHeader";
import TableContentGeneric from "../../components/admin/first/TableContentGeneric";
import Pagination from "../../components/admin/Pagination";
import SearchForm from "../../components/admin/first/SearchForm";
import FormInput from "../../components/admin/first/FormInput";


const AdminQnAContainer = () => {
  const [activeTab, setActiveTab] = useState("all");
  const [allQnaList, setAllQnaList] = useState([]);
  const [noAnswerQnaList, setNoAnswerQnaList] = useState([]);
  const [answeredQnaList, setAnsweredQnaList] = useState([]);
  const [currentQna, setCurrentQna] = useState(null);
  const [answers, setAnswers] = useState([]);
  const [pagination, setPagination] = useState({ page: 1, size: 10, totalPages: 1 });
  const [page, setPage] = useState(1);
  const [keyword, setKeyword] = useState("");
  const [newAnswer, setNewAnswer] = useState("");
  const [editAnswerId, setEditAnswerId] = useState(null);
  const [editAnswerContent, setEditAnswerContent] = useState("");
  const editTextareaRef = useRef(null);

  const tabs = [
    { key: "all", label: "전체 목록" },
    { key: "noanswer", label: "답변 없는 문의" },
    { key: "answered", label: "답변 있는 문의" }
  ];

  const qnaColumns = [
    { label: "제목", style: { flexBasis: "60%" }, render: (q) => q.title },
    { label: "작성일", style: { flexBasis: "40%" }, render: (q) => new Date(q.createdAt).toLocaleDateString() }
  ];

  /** 목록만 불러오기 */
  const fetchQnaList = async () => {
    try {
      const res = await getQnaList(page, pagination.size, keyword);
      if (res.data.success) {
        setAllQnaList(res.data.allQnaList || []);
        setNoAnswerQnaList(res.data.noAnswerQnaList || []);
        setAnsweredQnaList(res.data.answeredQnaList || []);
        if (res.data.pagination) {
          setPagination(res.data.pagination);
        }
      }
    } catch (err) {
      console.error("QnA 목록 조회 실패", err);
    }
  };

  /** 상세만 불러오기 */
  const fetchQnaDetail = async (id) => {
    try {
      const res = await getQnaList(1, 10, "", id);
      if (res.data.success) {
        setCurrentQna(res.data.currentQna || null);
        setAnswers(res.data.answers || []);
      }
    } catch (err) {
      console.error("QnA 상세 조회 실패", err);
    }
  };

  useEffect(() => {
    fetchQnaList();
  }, [page, keyword]);

  const dataForTab =
    activeTab === "all"
      ? allQnaList
      : activeTab === "noanswer"
      ? noAnswerQnaList
      : answeredQnaList;

  const handleCreateAnswer = async (e) => {
    e.preventDefault();
    await createQnaAnswer(currentQna.id, newAnswer);
    setNewAnswer("");
    fetchQnaDetail(currentQna.id);
  };

  const handleEditAnswer = (ans) => {
    setEditAnswerId(ans.id);
    setEditAnswerContent(ans.content);
    setTimeout(() => {
      editTextareaRef.current?.focus();
    }, 0);
  };

  const saveEditAnswer = async (e) => {
    e.preventDefault();
    await updateQnaAnswer(editAnswerId, currentQna.id, editAnswerContent);
    setEditAnswerId(null);
    setEditAnswerContent("");
    fetchQnaDetail(currentQna.id);
  };

  const removeAnswer = async (id) => {
    if (!window.confirm("삭제하시겠습니까?")) return;
    await deleteQnaAnswer(id);
    fetchQnaDetail(currentQna.id);
  };

  const removeQnaItem = async (id) => {
    if (!window.confirm("질문을 삭제하시겠습니까?")) return;
    await deleteQna(id);
    fetchQnaList();
    setCurrentQna(null);
    setAnswers([]);
  };

  return (
    <main className="py-5 bg-resonos-dark" style={{ minHeight: "80vh" }}>
      <div className="container" style={{ maxWidth: 1200 }}>
        <h2 className="mb-4 text-light-gold fw-bold">Q&A 관리</h2>

        <SearchForm initialKeyword={keyword} onSearch={setKeyword} placeholder="제목 검색" />

        <div className="row gx-4">
          {/* 좌측 목록 */}
          <div className="col-md-4">
            <TabsGeneric tabs={tabs} activeKey={activeTab} onChange={setActiveTab} />
            <TableColumnHeader columns={qnaColumns} />
            <TableContentGeneric
              items={dataForTab}
              columns={qnaColumns}
              onRowClick={(row) => fetchQnaDetail(row.id)}
              pagination={pagination}
            />
          </div>

          {/* 우측 상세 */}
          <div className="col-md-8">
            <section
              className="resonos-card p-4 bg-resonos-dark rounded-3 mt-4 overflow-auto"
              style={{ maxHeight: "70vh" }}
            >
              {!currentQna ? (
                <p className="text-center text-muted fs-5">문의글을 선택하세요.</p>
              ) : (
                <>
                  <h4>{currentQna.title}</h4>
                  <p style={{ whiteSpace: "pre-wrap" }}>{currentQna.content}</p>
                  <small className="text-muted">
                    작성일: {new Date(currentQna.createdAt).toLocaleString()}
                  </small>
                  <hr />
                  <h5>답변 목록</h5>
                  {answers.length === 0 && (
                    <div className="text-muted fst-italic mb-3">등록된 답변이 없습니다.</div>
                  )}
                  <ul className="list-group mb-3">
                    {answers.map((ans) => (
                      <li key={ans.id} className="list-group-item bg-dark text-light">
                        {editAnswerId === ans.id ? (
                          <form onSubmit={saveEditAnswer}>
                            <textarea
                              ref={editTextareaRef}
                              className="form-control mb-2"
                              rows="5"
                              value={editAnswerContent}
                              onChange={(e) => setEditAnswerContent(e.target.value)}
                              required
                            />
                            <button className="btn btn-warning btn-sm me-2">수정완료</button>
                            <button
                              type="button"
                              className="btn btn-secondary btn-sm"
                              onClick={() => setEditAnswerId(null)}
                            >
                              취소
                            </button>
                          </form>
                        ) : (
                          <>
                            <p style={{ whiteSpace: "pre-wrap" }}>{ans.content}</p>
                            <small>{new Date(ans.answeredAt).toLocaleString()}</small>
                            <div>
                              <button className="btn btn-outline-warning btn-sm me-2" onClick={() => handleEditAnswer(ans)}>수정</button>
                              <button className="btn btn-outline-danger btn-sm" onClick={() => removeAnswer(ans.id)}>삭제</button>
                            </div>
                          </>
                        )}
                      </li>
                    ))}
                  </ul>

                  {/* 답변 등록 */}
                  <form onSubmit={handleCreateAnswer}>
                    <FormInput
                      label="답변 내용"
                      type="textarea"
                      name="content"
                      value={newAnswer}
                      onChange={(e) => setNewAnswer(e.target.value)}
                      required
                      containerClassName="mb-3"
                    />
                    <button type="submit" className="btn btn-gold px-4">등록</button>
                  </form>

                  <div className="mt-3">
                    <button
                      className="btn btn-outline-danger btn-sm"
                      onClick={() => removeQnaItem(currentQna.id)}
                    >
                      질문 삭제
                    </button>
                  </div>
                </>
              )}
            </section>
          </div>
        </div>

        {pagination.totalPages > 1 && (
          <Pagination
            page={page}
            first={1}
            last={pagination.totalPages}
            prev={page > 1 ? page - 1 : 1}
            next={page < pagination.totalPages ? page + 1 : pagination.totalPages}
            start={Math.max(1, page - 4)}
            end={Math.min(pagination.totalPages, page + 5)}
            pageUri={`/admin/qna?keyword=${encodeURIComponent(keyword)}`}
            onPageChange={setPage}
          />
        )}
      </div>
    </main>
  );
};

export default AdminQnAContainer;
