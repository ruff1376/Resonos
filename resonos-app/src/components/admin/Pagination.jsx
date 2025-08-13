import React from 'react';

const Pagination = ({
  page,       // 현재 페이지 (number)
  first,      // 첫 페이지 번호 (보통 1)
  prev,       // 이전 페이지 번호
  next,       // 다음 페이지 번호
  last,       // 마지막 페이지 번호
  start,      // 페이지 번호 시작 (예: 1 또는 특정 숫자)
  end,        // 페이지 번호 끝 (예: 10 또는 특정 숫자)
  pageUri,    // 링크 기본 URI (ex: '/admin/members?keyword=abc')
  onPageChange // 페이지 변경 콜백 함수 (ex: (newPage) => {...})
}) => {
  
  // 페이지 이동 클릭 핸들러
  const handleClick = (e, targetPage) => {
    e.preventDefault();
    if (targetPage !== page) {
      onPageChange(targetPage);
    }
  };
  
  // 페이지 번호 배열 생성: start ~ end
  const pages = [];
  for (let i = start; i <= end; i++) {
    pages.push(i);
  }

  return (
    <nav aria-label="Page navigation">
      <ul className="custom-pagination">
        
        {/* 첫 페이지 */}
        <li>
          <a
            href={`${pageUri}&page=${first}`}
            aria-label="First"
            onClick={e => handleClick(e, first)}
          >
            <span aria-hidden="true">&laquo;</span>
          </a>
        </li>

        {/* 이전 페이지 (첫 페이지가 아니면) */}
        {page !== first && (
          <li>
            <a
              href={`${pageUri}&page=${prev}`}
              aria-label="Previous"
              onClick={e => handleClick(e, prev)}
            >
              <span aria-hidden="true">&lsaquo;</span>
            </a>
          </li>
        )}

        {/* 번호 페이지 */}
        {pages.map(p => (
          <li key={p} className={page === p ? 'active' : ''}>
            <a
              href={`${pageUri}&page=${p}`}
              onClick={e => handleClick(e, p)}
            >
              {p}
            </a>
          </li>
        ))}

        {/* 다음 페이지 (마지막 페이지가 아니면) */}
        {page !== last && (
          <li>
            <a
              href={`${pageUri}&page=${next}`}
              aria-label="Next"
              onClick={e => handleClick(e, next)}
            >
              <span aria-hidden="true">&rsaquo;</span>
            </a>
          </li>
        )}

        {/* 마지막 페이지 */}
        <li>
          <a
            href={`${pageUri}&page=${last}`}
            aria-label="Last"
            onClick={e => handleClick(e, last)}
          >
            <span aria-hidden="true">&raquo;</span>
          </a>
        </li>
      </ul>
    </nav>
  );
};

export default Pagination;
