import React, { useState, useEffect } from 'react';
import Index from '../../components/admin/Index';

const AdminContainer = () => {
  const [stats, setStats] = useState([
    // 초기값 혹은 로딩 상태
    { title: '회원', value: 0 },
    { title: '게시글', value: 0 },
    { title: '신고', value: 0 },
    { title: '블라인드', value: 0 },
  ]);

  useEffect(() => {
    // 여기에 API 호출 등 데이터 fetch 로직 넣기 가능
    // fetch().then(data => setStats(data))

    // 예시: 데이터 임시 변경
    setStats([
      { title: '회원', value: 100 },
      { title: '게시글', value: 250 },
      { title: '신고', value: 5 },
      { title: '블라인드', value: 3 },
    ]);
  }, []);

  return(
    <Index stats={stats} />
  ) 
};

export default AdminContainer;