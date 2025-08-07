import React from 'react';
import FormInput from '../first/FormInput'; // 경로는 실제 위치에 맞게 조정 필요
import { formatDate } from '../../../utils/format';  // format.js 위치에 맞게 경로 조정

const MemberDetailForm = ({
  detailMemberData,
  onChange,
  onSubmit,
  onDelete,
  onClose,
}) => {
  if (!detailMemberData) return null;

  return (
<div
  className="detail-info mt-3 p-3 border  rounded bg-var(--main-color); text-dark"
  style={{ width: '100%' }}
>

      <h5>회원 상세 정보</h5>
      <form onSubmit={onSubmit}>
        <div className="row">
          <FormInput
            label="아이디:"
            name="username"
            value={detailMemberData.username || ''}
            onChange={onChange}
            required
            autoComplete="off"
          />
          <FormInput
            label="닉네임:"
            name="nickname"
            value={detailMemberData.nickname || ''}
            onChange={onChange}
            required
            autoComplete="off"
          />
          <FormInput
            label="이메일:"
            name="email"
            type="email"
            value={detailMemberData.email || ''}
            onChange={onChange}
            required
            autoComplete="off"
          />
          <FormInput
            label="비밀번호 (변경시만 입력):"
            name="password"
            type="password"
            value={detailMemberData.password || ''}
            onChange={onChange}
            placeholder="변경할 비밀번호를 입력하세요"
            autoComplete="new-password"
            required={false}
          />
          <FormInput
            label="프로필 이미지 URL:"
            name="profileImage"
            value={detailMemberData.profileImage || ''}
            onChange={onChange}
            autoComplete="off"
          />
          {detailMemberData.profileImage && (
            <div className="col-12 text-start mb-3">
              <img
                src={detailMemberData.profileImage}
                alt="프로필"
                style={{ maxWidth: '100px' }}
              />
            </div>
          )}
          <div className="col-12 text-start mb-3">
            <label className="form-label" htmlFor="bio">
              소개(Bio):
            </label>
            <textarea
              id="bio"
              name="bio"
              className="form-control"
              value={detailMemberData.bio || ''}
              onChange={onChange}
              rows={3}
              style={{ width: '100%' }}
              placeholder="간단한 소개를 입력하세요"
            />
          </div>
          <div className="col-md-6 text-start mb-3">
            <label className="form-label" htmlFor="isPro">
              전문가 여부(isPro):
            </label>
            <select
              id="isPro"
              name="isPro"
              className="form-select"
              value={detailMemberData.isPro ? 'true' : 'false'}
              onChange={onChange}
            >
              <option value="true">예</option>
              <option value="false">아니오</option>
            </select>
          </div>
          <div className="col-md-6 text-start mb-3">
            <label className="form-label" htmlFor="enabled">
              상태:
            </label>
            <select
              id="enabled"
              name="enabled"
              className="form-select"
              value={detailMemberData.enabled ? 'true' : 'false'}
              onChange={onChange}
            >
              <option value="true">정상</option>
              <option value="false">휴면</option>
            </select>
          </div>
          <div className="col-md-6 text-start mb-3">
            <label className="form-label" htmlFor="auth">
              권한:
            </label>
            <select
              id="auth"
              name="auth"
              className="form-select"
              value={detailMemberData.auth || ''}
              onChange={onChange}
            >
              <option value="ROLE_USER">일반</option>
              <option value="ROLE_ADMIN">운영자</option>
            </select>
          </div>
          <FormInput
            label="Provider:"
            name="provider"
            value={detailMemberData.provider || ''}
            onChange={onChange}
            autoComplete="off"
            containerClassName="col-md-6 text-start mb-3"
          />
          <FormInput
            label="Provider ID:"
            name="providerId"
            value={detailMemberData.providerId || ''}
            onChange={onChange}
            autoComplete="off"
            containerClassName="col-md-6 text-start mb-3"
          />

          {/* 제재 내역 출력 (있으면 리스트로) */}
            <div className="col-12 text-start mb-3">
            <label>제재 내역:</label>
            {detailMemberData.sanctions && detailMemberData.sanctions.length > 0 ? (
                <ul style={{ maxHeight: '150px', overflowY: 'auto', paddingLeft: '20px' }}>
                {detailMemberData.sanctions.map((sanction, idx) => (
                    <li key={idx} style={{ marginBottom: '8px' }}>
                    <strong>타입:</strong> {sanction.type || '없음'}<br />
                    <strong>사유:</strong> {sanction.reason || '없음'}<br />
                    <strong>기간:</strong> {formatDate(sanction.startAt)}
                    {sanction.endAt ? ` ~ ${formatDate(sanction.endAt)}` : ''}
                    <br />
                    <small style={{ color: '#666' }}>
                        등록일: {formatDate(sanction.createdAt)}
                    </small>
                    </li>
                ))}
                </ul>
            ) : (
                <p>제재 내역이 없습니다.</p>
            )}
            </div>

          <div className="col-12 text-end">
            <button type="submit" className="btn btn-gold btn-sm me-2">
              저장
            </button>
            <button
              type="button"
              className="btn btn-outline-secondary btn-sm me-2"
              onClick={onClose}
            >
              닫기
            </button>
            <button type="button" className="btn btn-outline-danger btn-sm" onClick={onDelete}>
              삭제
            </button>
          </div>
        </div>
      </form>
    </div>
  );
};

export default MemberDetailForm;
