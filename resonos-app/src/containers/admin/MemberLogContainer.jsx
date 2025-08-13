import React, { useEffect, useState } from 'react';
import { useParams } from 'react-router-dom';
import LogTable from '../../components/admin/first/LogTable'; // 새로 제공된 컴포넌트
import { formatDate as formatDateTime } from '../../utils/format';
import { getMemberLogsByUserId } from '../../apis/admin';
import QuickMenu from '../../components/admin/first/QuickMenu';


const MemberLogContainer = ({ userId }) => {
  const [logs, setLogs] = useState([]);
  const [loading, setLoading] = useState(false);

  // LogTable에서 사용하는 컬럼 정의. key는 반드시 있어야 하고, isDate도 옵션으로 사용
  const columns = [
    { label: '일시', key: 'createdAt', isDate: true, style: { width: '15%' } },
    { label: '행동', key: 'action', style: { width: '20%' } },
    { label: '상세 내용', key: 'detail', style: { width: '35%' } },
    { label: 'IP', key: 'ipAddress', style: { width: '15%' } },
    { label: '유형', key: 'targetType', style: { width: '15%' } },
  ];

useEffect(() => {
  console.log('MemberLogContainer useEffect 실행, userId:', userId);

  if (!userId) {
    setLogs([]);
    setLoading(false);
    return;
  }

  setLoading(true);
  getMemberLogsByUserId(userId)
    .then(res => {
      console.log('받은 활동 로그:', res.data);
      setLogs(res.data || []);
    })
    .catch(error => {
      console.error('활동 로그 조회 실패', error);
      setLogs([]);
    })
    .finally(() => setLoading(false));
}, [userId]);

  return (
    <main className="resonos-bg py-5" style={{ minHeight: '100vh' }}>
      <div className="container" style={{ maxWidth: 900 }}>
        <h2 className="mb-4" style={{ color: '#fffbe6' }}>
          회원 활동 로그
        </h2>

        {loading ? (
          <div>로딩중...</div>
        ) : (
          <LogTable
            data={logs}
            columns={columns}
            noDataText="활동 로그가 없습니다."
            dateFormatFunc={formatDateTime}
          />
        )}

        <a href="/admin/members" className="btn btn-outline-gold mt-3">
          회원 목록으로
        </a>
      </div>
      <QuickMenu />
    </main>
  );
};

export default MemberLogContainer;
