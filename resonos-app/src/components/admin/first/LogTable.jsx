import React from 'react';

// LogTable.jsx 수정 예시
const LogTable = ({ 
  data = [], 
  columns = [], 
  noDataText = '데이터가 없습니다.', 
  dateFormatFunc = (val) => val 
}) => {
  return (
<div className="admin resonos-card p-4">
  <table className="table table-hover align-middle resonos-table">
    <thead className="table-header">
      <tr>
        {columns.map((col, idx) => (
          <th key={idx} style={col.style}>{col.label}</th>
        ))}
      </tr>
    </thead>
    <tbody>
      {data.length > 0 ? (
        data.map((item, index) => (
          <tr key={item.id || index}>
            {columns.map(({ key, isDate }, ci) => {
              let value = item[key];
              if (isDate && value) {
                try {
                  value = dateFormatFunc(value);
                } catch (e) {
                  console.error('dateFormatFunc error:', e);
                  value = '-';
                }
              }
              return <td key={ci}>{value ?? '-'}</td>;
            })}
          </tr>
        ))
      ) : (
        <tr>
          <td colSpan={columns.length} className="text-center text-secondary">
            {noDataText}
          </td>
        </tr>
      )}
    </tbody>
  </table>
</div>

  );
};


export default LogTable;
