import React, { useState, useEffect } from 'react';
import TableColumnHeader from '../../components/admin/first/TableColumnHeader';
import TableContentGeneric from '../../components/admin/first/TableContentGeneric';
import Pagination from '../../components/admin/Pagination';
import TabsGeneric from '../../components/admin/first/TabsGeneric';
import ReportDetailPanel from '../../components/admin/second/ReportDetailPanel';

// 새 API 임포트 (user 제공)
import { 
  getReports, 
  getReportDetail, 
  deleteReport, 
  updateReportStatus
} from '../../apis/admin';
import QuickMenu from '../../components/admin/first/QuickMenu';

const AdminReportsContainer = () => {
  // 상태
  const [reports, setReports] = useState([]);
  const [pagination, setPagination] = useState({ page: 1, size: 10, total: 0, totalPages: 1 });
  const [page, setPage] = useState(1);
  const [selectedTab, setSelectedTab] = useState('all'); // 탭 상태
  const [tabsData, setTabsData] = useState([
    { key: 'all', label: '전체', count: 0 },
    { key: 'pending', label: '처리대기', count: 0 },
    { key: 'done', label: '처리완료', count: 0 },
    { key: 'rejected', label: '반려', count: 0 },
  ]);
  const [detailReportId, setDetailReportId] = useState(null);
  const [detailReportData, setDetailReportData] = useState(null);
  const [loading, setLoading] = useState(false);

  const startPage = Math.max(1, page - 4);
  const endPage = Math.min(pagination.totalPages || 1, page + 5);
  const pageUri = `/admin/reports?tab=${selectedTab}`;

  /** 테이블 컬럼 정의 */
  const reportColumns = [
    { label: 'ID', style: { flexBasis: '8%', minWidth: '60px' }, render: (r) => r.id },
    { label: '유형', style: { flexBasis: '10%', minWidth: '80px' }, render: (r) => r.targetType },
    { label: '대상ID', style: { flexBasis: '10%', minWidth: '80px' }, render: (r) => r.targetId },
    { label: '사유', style: { flexBasis: '16%', minWidth: '120px' }, render: (r) => r.reason },
    { label: '신고자', style: { flexBasis: '10%', minWidth: '80px' }, render: (r) => r.reporterId },
    { label: '일시', style: { flexBasis: '10%', minWidth: '80px' }, render: (r) => r.createdAt },
    { label: '상태', style: { flexBasis: '10%', minWidth: '80px' }, render: (r) => r.status },
    { label: '처리자', style: { flexBasis: '10%', minWidth: '80px' }, render: (r) => r.processedBy || '-' },
    {
      label: '관리',
      style: { flexBasis: '16%', minWidth: '120px' },
      render: (r) => (
        <>
          <button onClick={() => handleShowDetail(r.id)} className="btn btn-outline-gold btn-sm">
            상세
          </button>
          <button className="btn btn-outline-danger btn-sm ms-1" onClick={() => handleDelete(r.id)}>
            삭제
          </button>
        </>
      ),
    },
  ];

  /** 목록 조회 */
  /** 목록 조회 */
const fetchReports = async (tab = selectedTab, pageNum = page, size = pagination.size) => {
  setLoading(true);
  try {
    const res = await getReports(tab, pageNum, size);
    const data = res.data;

    // 목록
    setReports(data.reports || []);

    // 페이지네이션 정보 설정 (data.pagination 활용)
    if (data.pagination) {
    const p = data.pagination;
    const totalPages = Math.ceil(p.total / p.size);

    setPagination({
        page: p.page,           // 현재 페이지
        size: p.size,           // 페이지당 개수
        total: p.total,         // 전체 건수
        totalPages              // 계산된 전체 페이지 수
    });

    setPage(p.page); // 현재 페이지 state 동기화
    }

    // 탭 카운트 업데이트
    if (data.totals) {
      setTabsData(prev =>
        prev.map(t => ({
          ...t,
          count: data.totals[t.key] ?? 0
        }))
      );
    }

  } catch (e) {
    console.error('신고 목록 조회 실패', e);
  } finally {
    setLoading(false);
  }
};





  /** 상세보기 토글 & 데이터 불러오기 */
  const handleShowDetail = async (id) => {
    if (detailReportId === id) {
      setDetailReportId(null);
      setDetailReportData(null);
      return;
    }
    try {
      const res = await getReportDetail(id);
      setDetailReportId(id);
      setDetailReportData(res.data);
    } catch (e) {
      alert('상세 정보 조회 실패');
    }
  };

  /** 상태 변경 */
  const handleUpdateStatus = async (id, newStatus) => {
    try {
      await updateReportStatus(id, newStatus);
      alert('상태가 변경되었습니다.');
      fetchReports(selectedTab, page, pagination.size);
    } catch (e) {
      alert('상태 변경 실패');
    }
  };

  /** 삭제 */
  const handleDelete = async (id) => {
    if (!window.confirm('정말 삭제하시겠습니까?')) return;
    try {
      await deleteReport(id);
      alert('삭제되었습니다.');
      fetchReports(selectedTab, page, pagination.size);
    } catch (e) {
      alert('삭제 실패');
    }
  };

  /** 페이지 변경 */
  const onPageChange = (newPage) => {
    if (newPage === page) return;
    setPage(newPage);
  };

  /** 탭 변경 */
  const handleTabChange = (key) => {
    setSelectedTab(key);
    setPage(1);
  };

  /** 데이터 로딩 트리거 */
  useEffect(() => {
    fetchReports(selectedTab, page, pagination.size);
  }, [selectedTab, page]);

  return (
    <>
      <h1>Admin Reports</h1>

      {/* 탭 */}
      <TabsGeneric tabs={tabsData} activeKey={selectedTab} onChange={handleTabChange} />

      {/* 테이블 헤더 */}
      <TableColumnHeader columns={reportColumns} />

      {/* 리스트 */}
      {loading ? (
        <div>로딩중...</div>
      ) : (
        <TableContentGeneric
          items={reports}
          columns={reportColumns}
          pagination={pagination}
          renderDetail={(report) =>
            detailReportId === report.id && (
              <ReportDetailPanel
                report={detailReportData}
                onStatusChange={handleUpdateStatus}
                onDelete={handleDelete}
              />
            )
          }
        />
      )}

      {/* 페이징 */}
        <Pagination
        page={page}
        first={1}
        last={pagination.totalPages || 1}  // 이제 정상적으로 totalPages 값 표시
        prev={page > 1 ? page - 1 : 1}
        next={page < (pagination.totalPages || 1) ? page + 1 : (pagination.totalPages || 1)}
        start={startPage}
        end={endPage}
        pageUri={pageUri}
        onPageChange={onPageChange}
        />
<QuickMenu />
    </>
  );
};

export default AdminReportsContainer;
