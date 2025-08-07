import React from 'react';

const TableColumnHeader = ({ columns=[] }) => {
  const containerStyle = {
    borderRadius: '8px 8px 0 0',
  };
  const baseClass =
    'list-group-item bg-secondary text-dark fw-bold d-flex flex-nowrap align-items-center text-center justify-content-center';

  return (
    <div className={baseClass} style={containerStyle}>
      {columns.map(({ label, style }, index) => (
        <div key={index} style={{ flexBasis: style.flexBasis, minWidth: style.minWidth }}>
          {label}
        </div>
      ))}
    </div>
  );
};

TableColumnHeader.defaultProps = {
  columns: [
    { label: '번호', style: { flexBasis: '5%', minWidth: '40px' } },
    { label: '프로필', style: { flexBasis: '8%', minWidth: '60px' } },
    { label: '닉네임', style: { flexBasis: '12%', minWidth: '80px' } },
    { label: '이메일', style: { flexBasis: '18%', minWidth: '120px' } },
    { label: '가입일', style: { flexBasis: '10%', minWidth: '80px' } },
    { label: '상태', style: { flexBasis: '8%', minWidth: '60px' } },
    { label: '권한', style: { flexBasis: '8%', minWidth: '60px' } },
    { label: '활동 로그', style: { flexBasis: '14%', minWidth: '120px' } },
    { label: '관리', style: { flexBasis: '9%', minWidth: '80px' } },
    { label: '상세', style: { flexBasis: '8%', minWidth: '60px' } },
  ],
};

export default TableColumnHeader;
