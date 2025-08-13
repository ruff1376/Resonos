// components/admin/QuickMenu.jsx
import React from "react";
import ThemeToggle from '../first/ThemeToggle'; // 새로 만든 테마 토글
import ToMain from "./ToMain";

  const menuData = [
  [ // 1번째 줄
    { title: '회원 관리', link: '/admin/members', label: '회원 목록' },
    { title: '커뮤니티/신고 관리', link: '/admin/report', label: '게시글/신고' },
    { title: '음악 데이터 관리', link: '/admin/music', label: '아티스트/앨범/곡' },
    { title: '공연/이벤트 관리', link: '#', label: '공연/이벤트' },
  ],
  [ // 2번째 줄
    { title: '통계/분석', link: '#', label: '통계 대시보드' },
    { title: '권한/역할 관리', link: '/admin/role', label: '권한 관리' },
    { title: '오픈 API 관리', link: '/admin/AnP', label: 'API 키/쿼터' },
    { title: '정책/환경설정', link: '/admin/PolicySetting', label: '정책 설정' },
  ],
  [ // 3번째 줄
    { title: '배지 관리', link: '/admin/badge', label: '조건 관리' },
    { title: '태그 관리', link: '/admin/tags', label: '태그 관리' },
    { title: '투표 관리', link: '/admin/vote', label: '태그 확인' },
    { title: '리뷰 신고 관리', link: '/admin/report/review', label: '리뷰 신고' },
  ],
  [ // 4번째 줄
    { title: '알람', link: '/admin/notifications', label: '알람 관리' },
    { title: '공지사항', link: '/admin/notices', label: '공지사항' },
    { title: '기타', link: '/admin/qna', label: 'QnA 관리' },
    { title: '기타', link: '/admin/report/review', label: '설정' },
  ]
];

const QuickMenu = () => {
  const flatMenu = menuData.flat();
  
return (
  <div className="admin quick-menu">
    {flatMenu.map((item, idx) => (
      <a key={idx} href={item.link} className="quick-menu-item">
        {item.label}
      </a>
    ))}
    <ThemeToggle className="quick-menu-item" />
    <ToMain className="quick-menu-item" />
  </div>
);

};

export default QuickMenu;