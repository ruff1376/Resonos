import React from 'react';

const columns = (onToggleEnable, onBanToggle, onShowDetail, keyword) => [
  {
    label: '번호',
    style: { flexBasis: '5%', minWidth: '40px' },
    render: (member, index, pagination) => (pagination.index ?? 0) + index + 1,
  },
  {
    label: '프로필',
    style: { flexBasis: '8%', minWidth: '60px' },
    render: (member) => (
      <img
        src={member.profileImage || '/img/default-profile.png'}
        alt="프로필"
        style={{
          width: 38,
          height: 38,
          borderRadius: '50%',
          border: '1.5px solid #D4B97F',
          objectFit: 'cover',
          background: '#181C23',
        }}
      />
    ),
  },
  { label: '닉네임', style: { flexBasis: '12%', minWidth: '80px' }, render: (member) => member.nickname },
  { label: '이메일', style: { flexBasis: '18%', minWidth: '120px' }, render: (member) => member.email },
  {
    label: '가입일',
    style: { flexBasis: '10%', minWidth: '80px' },
    render: (member) => new Date(member.createdAt).toISOString().slice(0, 10),
  },
  {
    label: '상태',
    style: { flexBasis: '8%', minWidth: '60px' },
    render: (member) => {
      const isEnabled = Boolean(member.enabled);
      const isBanned = Boolean(member.ban);
      return (
        <>
          <span className={`badge ${isEnabled ? 'bg-gold' : 'bg-secondary'}`}>
            {isEnabled ? '정상' : '휴면'}
          </span>
          {isBanned && <span className="badge" style={{ background: '#d9534f' }}>제재</span>}
        </>
      );
    },
  },
  {
    label: '권한',
    style: { flexBasis: '8%', minWidth: '60px' },
    render: (member) =>
      member.authList?.map((auth, idx) => {
        const isAdmin = auth.auth === 'ROLE_ADMIN';
        return (
          <span
            key={idx}
            className={`badge ${isAdmin ? 'bg-gold' : 'bg-secondary'}`}
            style={{ marginRight: 4 }}
          >
            {isAdmin ? '운영자' : '일반'}
          </span>
        );
      }),
  },
  {
    label: '활동 로그',
    style: { flexBasis: '14%', minWidth: '120px' },
    render: (member) => (
      <a href={`/admin/members/logs?userId=${member.id}`} className="btn btn-outline-gold btn-sm mt-1">
        전체보기
      </a>
    ),
  },
  {
    label: '관리',
    style: { flexBasis: '9%', minWidth: '80px' },
    render: (member) => {
      const isEnabled = Boolean(member.enabled);
      const isBanned = Boolean(member.ban);

      return (
        <>
          <form
            onSubmit={(e) => {
              e.preventDefault();
              onToggleEnable(member.id, !isEnabled, keyword);
            }}
            style={{ display: 'inline' }}
          >
            <button type="submit" className="btn btn-outline-gold btn-sm">
              {isEnabled ? '비활성' : '활성'}
            </button>
          </form>

          {!isBanned ? (
            <button
              type="button"
              className="btn btn-outline-danger btn-sm ban-btn"
              onClick={() => onBanToggle(member.id, true, keyword)}
              style={{ marginLeft: 6 }}
            >
              제재
            </button>
          ) : (
            <form
              onSubmit={(e) => {
                e.preventDefault();
                onBanToggle(member.id, false, keyword);
              }}
              style={{ display: 'inline', marginLeft: 6 }}
            >
              <button type="submit" className="btn btn-outline-danger btn-sm">
                제재 해제
              </button>
            </form>
          )}
        </>
      );
    },
  },
  {
    label: '상세',
    style: { flexBasis: '8%', minWidth: '60px' },
    render: (member) => (
      <button
        type="button"
        className="btn btn-outline-gold btn-sm detail-btn"
        onClick={() => onShowDetail(member.id)}
      >
        상세
      </button>
    ),
  },
];

/**
 * @param {Array} members 멤버 데이터 배열
 * @param {Object} pagination 페이지네이션 정보
 * @param {string} keyword 검색 키워드
 * @param {Function} onToggleEnable 활성/비활성 토글 함수
 * @param {Function} onBanToggle 제재/해제 토글 함수
 * @param {Function} onShowDetail 상세 보기 함수
 */
const TableContent = ({
  members = [],
  pagination = {},
  keyword = '',
  onToggleEnable,
  onBanToggle,
  onShowDetail,
}) => {
  const cols = columns(onToggleEnable, onBanToggle, onShowDetail, keyword);

  return (
    <>
      {members.map((member, index) => (
        <div
          key={member.id}
          id={`row-${member.id}`}
          className="list-group-item bg-dark text-light border-secondary mb-2 rounded-0 d-flex flex-nowrap align-items-center text-center justify-content-center"
        >
          {cols.map(({ style, render }, colIndex) => (
            <div key={colIndex} style={{ flexBasis: style.flexBasis, minWidth: style.minWidth }}>
              {render(member, index, pagination)}
            </div>
          ))}
        </div>
      ))}
    </>
  );
};

export default TableContent;
