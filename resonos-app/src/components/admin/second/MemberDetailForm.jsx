import React from 'react';
import FormInput from '../first/FormInput'; // 경로는 실제 위치에 맞게 조정 필요
import { formatDate } from '../../../utils/format';  // format.js 위치에 맞게 경로 조정
import FormSelect from '../first/FormSelect';

const MemberDetailForm = ({
  detailMemberData,
  onChange,
  onSubmit,
  onDelete,
  onClose,
}) => {
  if (!detailMemberData) return null;

return (
  <div className="member-detail-form resonos-card p-3">
    <h5>회원 상세 정보</h5>
    <form onSubmit={onSubmit}>
      <div className="row">
        {/* 기본 정보 입력 */}
        <FormInput label="아이디:" name="username" value={detailMemberData.username || ''} onChange={onChange} required />
        <FormInput label="닉네임:" name="nickname" value={detailMemberData.nickname || ''} onChange={onChange} required />
        <FormInput label="이메일:" name="email" type="email" value={detailMemberData.email || ''} onChange={onChange} required />
        <FormInput label="비밀번호 (변경시만 입력):" name="password" type="password" value={detailMemberData.password || ''} onChange={onChange} placeholder="변경할 비밀번호 입력" required={false} />

        <FormInput label="프로필 이미지 URL:" name="profileImage" value={detailMemberData.profileImage || ''} onChange={onChange} />
        {detailMemberData.profileImage && (
          <div className="col-12 text-start mb-3">
            <img src={detailMemberData.profileImage} alt="프로필" style={{ maxWidth: '100px' }} />
          </div>
        )}

        <div className="col-12 text-start mb-3">
          <label className="form-label">소개(Bio):</label>
          <textarea
            name="bio"
            className="form-control"
            value={detailMemberData.bio || ''}
            onChange={onChange}
            rows={3}
            placeholder="간단한 소개"
          />
        </div>

        {/* 셀렉트 필드 */}
        <FormSelect label="전문가 여부(isPro)" name="isPro" value={detailMemberData.isPro ? 'true' : 'false'} onChange={onChange} options={[{ value: 'true', label: '예' }, { value: 'false', label: '아니오' }]} containerClassName="col-md-6 text-start mb-3" />
        <FormSelect label="상태" name="enabled" value={detailMemberData.enabled ? 'true' : 'false'} onChange={onChange} options={[{ value: 'true', label: '정상' }, { value: 'false', label: '휴면' }]} containerClassName="col-md-6 text-start mb-3" />
        <FormSelect label="권한" name="auth" value={detailMemberData.auth || ''} onChange={onChange} options={[{ value: 'ROLE_USER', label: '일반' }, { value: 'ROLE_ADMIN', label: '운영자' }]} containerClassName="col-md-6 text-start mb-3" />

        <FormInput label="Provider:" name="provider" value={detailMemberData.provider || ''} onChange={onChange} containerClassName="col-md-6 text-start mb-3" />
        <FormInput label="Provider ID:" name="providerId" value={detailMemberData.providerId || ''} onChange={onChange} containerClassName="col-md-6 text-start mb-3" />

        {/* 제재 내역 */}
        <div className="col-12 text-start mb-3">
          <label>제재 내역:</label>
          {detailMemberData.sanctions?.length > 0 ? (
            <ul style={{ maxHeight: '150px', overflowY: 'auto', paddingLeft: '20px' }}>
              {detailMemberData.sanctions.map((s, idx) => (
                <li key={idx} style={{ marginBottom: '8px' }}>
                  <strong>타입:</strong> {s.type || '없음'}<br />
                  <strong>사유:</strong> {s.reason || '없음'}<br />
                  <strong>기간:</strong> {formatDate(s.startAt)} {s.endAt && `~ ${formatDate(s.endAt)}`}<br />
                  <small style={{ color: '#666' }}>등록일: {formatDate(s.createdAt)}</small>
                </li>
              ))}
            </ul>
          ) : (
            <p>제재 내역이 없습니다.</p>
          )}
        </div>

        {/* 버튼 */}
        <div className="col-12 text-end">
          <button type="submit" className="btn btn-gold btn-sm me-2">저장</button>
          <button type="button" className="btn btn-outline-gold btn-sm me-2" onClick={onClose}>닫기</button>
          <button type="button" className="btn btn-outline-danger btn-sm" onClick={onDelete}>삭제</button>
        </div>
      </div>
    </form>
  </div>
);

};

export default MemberDetailForm;
