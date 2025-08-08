import React, { useState, useEffect } from 'react';

// Pagination, SearchForm, TableHeader, TableContent, DetailForm 등은 아래 임포트
// 실제 프로젝트에 맞게 경로 및 내용 수정하세요
import Pagination from '../../components/admin/Pagination';
import SearchForm from '../../components/admin/first/SearchForm';
import TableColumnHeader from '../../components/admin/first/TableColumnHeader';
import TableContent from '../../components/admin/first/TableContent';
import DetailForm from '../../components/admin/first/DetailForm';

const DefaultContainer = ({
  listApi,              // (page, size, keyword) => Promise<{items: [], pagination: {}, ...}>
  selectApi,            // (id) => Promise<item>
  updateApi,            // (item) => Promise<void>
  deleteApi,            // (id) => Promise<void>
  insertApi,            // (item) => Promise<void>
  columns,              // 테이블 컬럼 정의 [{ label, key, style }]
  size = 10,            // 페이지당 기본 아이템 수
  detailKey = 'id',     // 상세 아이템 식별 키명, 기본 'id'
  showAddButton = true, // 회원 등록(추가) 버튼 노출 여부
  renderDetailExtra,    // 상세폼 커스텀 영역 렌더 함수(item) => JSX
  renderTableExtra,     // 테이블 하단 추가 엘리먼트 렌더 함수 (예: bulk action 등)
}) => {
  const [items, setItems] = useState([]);
  const [pagination, setPagination] = useState({
    page: 1,
    size,
    total: 0,
    totalPages: 1,
  });
  const [keyword, setKeyword] = useState('');
  const [page, setPage] = useState(1);
  const [loading, setLoading] = useState(false);
  const [showAddForm, setShowAddForm] = useState(false);

  // 상세보기
  const [detailId, setDetailId] = useState(null);
  const [detailData, setDetailData] = useState(null);
  const [originalDetailData, setOriginalDetailData] = useState(null);

  // 리스트 조회 함수
  const fetchList = async (pageNum = 1, pageSize = size, kw = '') => {
    setLoading(true);
    try {
      const res = await listApi(pageNum, pageSize, kw);
      // res는 { items: [], pagination: { page, size, total, totalPages } } 형태로 간주
      setItems(res.items || []);
      const p = res.pagination || {};
      setPagination({
        page: p.page ?? pageNum,
        size: p.size ?? pageSize,
        total: p.total ?? 0,
        totalPages: p.totalPages ?? 1,
      });
      setPage(p.page ?? pageNum);
    } catch (e) {
      console.error('목록 조회 실패:', e);
    } finally {
      setLoading(false);
    }
  };

  // 상세 조회 함수
  const fetchDetail = async (id) => {
    if (!id) {
      setDetailData(null);
      setOriginalDetailData(null);
      setDetailId(null);
      return;
    }
    try {
      const res = await selectApi(id);
      setDetailData(res);
      setOriginalDetailData(res);
      setDetailId(id);
    } catch (e) {
      alert('상세 정보 불러오기 실패');
    }
  };

  // 페이지 변경 핸들러
  const onPageChange = (newPage) => {
    if (newPage === page) return;
    setPage(newPage);
    fetchList(newPage, size, keyword);
  };

  // 검색 핸들러
  const onSearch = (kw) => {
    setKeyword(kw);
    setPage(1);
    fetchList(1, size, kw);
  };

  // 상세 데이터 변경 처리
  const onDetailChange = (field, value) => {
    setDetailData((prev) => ({
      ...prev,
      [field]: value,
    }));
  };

  // 상세 저장
  const onDetailSubmit = async () => {
    if (!detailData) return;
    try {
      await updateApi(detailData);
      alert('저장되었습니다.');
      setDetailId(null);
      setDetailData(null);
      fetchList(page, size, keyword);
    } catch (e) {
      alert('저장 실패: ' + (e.message || e));
    }
  };

  // 삭제
  const onDelete = async () => {
    if (!detailId) return;
    if (!window.confirm('정말 삭제하시겠습니까?')) return;
    try {
      await deleteApi(detailId);
      alert('삭제되었습니다.');
      setDetailId(null);
      setDetailData(null);
      fetchList(page, size, keyword);
    } catch (e) {
      alert('삭제 실패: ' + (e.message || e));
    }
  };

  // 추가 등록 폼 제출
  const onAddSubmit = async (newData) => {
    try {
      await insertApi(newData);
      alert('등록되었습니다.');
      setShowAddForm(false);
      fetchList(page, size, keyword);
    } catch (e) {
      alert('등록 실패: ' + (e.message || e));
    }
  };

  // 상세 열고 닫기 토글
  const toggleDetail = (id) => {
    if (detailId === id) {
      setDetailId(null);
      setDetailData(null);
      setOriginalDetailData(null);
    } else {
      fetchDetail(id);
    }
  };

  // 초기 리스트 로드
  useEffect(() => {
    fetchList(page, size, keyword);
  }, []);

  return (
    <div>
      {showAddButton && !showAddForm && (
        <button onClick={() => setShowAddForm(true)}>등록하기</button>
      )}
      {showAddForm && (
        <DetailForm
          data={{}}
          onCancel={() => setShowAddForm(false)}
          onSubmit={onAddSubmit}
          readOnly={false}
        />
      )}
      <SearchForm onSearch={onSearch} />
      {loading ? (
        <div>로딩중...</div>
      ) : (
        <>
          <TableColumnHeader columns={columns} />
          <TableContent
            items={items}
            columns={columns}
            onRowClick={(item) => toggleDetail(item[detailKey])}
          />
          {renderTableExtra && renderTableExtra({ items, pagination })}
          <Pagination
            page={page}
            first={1}
            last={pagination.totalPages}
            prev={page > 1 ? page - 1 : 1}
            next={page < pagination.totalPages ? page + 1 : pagination.totalPages}
            start={Math.max(1, page - 4)}
            end={Math.min(pagination.totalPages, page + 5)}
            pageUri={`?keyword=${encodeURIComponent(keyword)}`}
            onPageChange={onPageChange}
          />
          {detailId && detailData && (
            <DetailForm
              data={detailData}
              originalData={originalDetailData}
              onChange={onDetailChange}
              onSubmit={onDetailSubmit}
              onDelete={onDelete}
              onCancel={() => setDetailId(null)}
              readOnly={false}
              // 상세 추가 커스텀 영역 렌더 함수 전달 가능
              renderExtra={renderDetailExtra}
            />
          )}
        </>
      )}
    </div>
  );
};

export default DefaultContainer;
