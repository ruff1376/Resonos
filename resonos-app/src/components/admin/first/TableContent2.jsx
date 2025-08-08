import React, { useState } from 'react';
import BanMemberForm from '../second/BanMemberForm';
import MemberDetailForm from '../second/MemberDetailForm';

const TableContent = ({
  members = [],
  setMembers,
  pagination = {},
  keyword = '',
  onToggleEnable,
  onBanToggle,
  onShowDetail,
  detailMemberId,
  detailMemberData,
  onDetailChange,
  onDetailSubmit,
  onDelete,
  onCloseDetail,
  columns, // columns 함수는 외부에서 생성된 배열 또는 함수가 아닌 완성된 배열로 전달 권장
}) => {
  const [banFormUserId, setBanFormUserId] = useState(null);

  // BanMemberForm 완료 시 호출되는 함수
  const handleBanComplete = (userId) => {
    setMembers(prevMembers =>
      prevMembers.map(m => (m.id === userId ? { ...m, ban: true } : m))
    );
    setBanFormUserId(null);
  };

  // 실제 렌더링할 컬럼 배열으로 columns가 전달된다고 가정
  // 만약 columns가 함수라면 미리 호출해서 완성된 배열을 받는걸 권장합니다.

  return (
    <>
      {members.map((member, index) => (
        <React.Fragment key={member.id}>
          <div
            id={`row-${member.id}`}
            className="list-group-item bg-dark text-light border-secondary mb-2 rounded-0 d-flex flex-nowrap align-items-center text-center justify-content-center"
          >
            {columns.map(({ style, render }, colIndex) => (
              <div
                key={colIndex}
                style={{ flexBasis: style.flexBasis, minWidth: style.minWidth }}
              >
                {render(member, index, pagination)}
              </div>
            ))}
          </div>

          {/* 제재 폼 */}
          {banFormUserId === member.id && (
            <div style={{ marginLeft: '5%', marginBottom: '20px' }}>
              <BanMemberForm
                userId={member.id}
                onCancel={() => setBanFormUserId(null)}
                onComplete={() => {
                  setBanFormUserId(null);
                  handleBanComplete(member.id);
                }}
              />
            </div>
          )}

          {/* 상세 폼 */}
          {detailMemberId === member.id && detailMemberData && (
            <div style={{ marginLeft: '5%', marginBottom: '20px' }}>
              <MemberDetailForm
                detailMemberData={detailMemberData}
                onChange={onDetailChange}
                onSubmit={onDetailSubmit}
                onDelete={onDelete}
                onClose={onCloseDetail}
              />
            </div>
          )}
        </React.Fragment>
      ))}
    </>
  );
};

export default TableContent;
