import React, { useState } from 'react';
import { banUser } from '../../../apis/admin'; // banUser API 호출 함수

const BanMemberForm = ({ userId, onComplete, onCancel }) => {
  const [banReason, setBanReason] = useState('');
  const [type, setType] = useState('');
  const [startAt, setStartAt] = useState('');
  const [endAt, setEndAt] = useState('');
  const [loading, setLoading] = useState(false);

  const handleSubmit = async (e) => {
    e.preventDefault();

    if (!type.trim()) {
      alert('제재 유형을 선택하세요.');
      return;
    }
    if (!startAt.trim()) {
      alert('시작일을 입력하세요.');
      return;
    }
    if (!banReason.trim()) {
      alert('제재 사유를 입력하세요.');
      return;
    }
    if (endAt && startAt > endAt) {
      alert('종료일이 시작일보다 빠를 수 없습니다.');
      return;
    }
    if (!window.confirm('정말 제재하시겠습니까?')) return;

    try {
      setLoading(true);
      // banUser API 호출: userId, ban=true, reason, 추가 필드(타입, 기간)도 적절히 포함해서 호출 필요
      // 여기선 예시로 세 개 정보 전송한다고 가정. 실제 API에 맞게 조정하세요.
      const response = await banUser(userId, true, banReason, {
        type,
        startAt,
        endAt: endAt || null,
      });
      console.log('Ban submit success', response);
      alert('제재 처리가 완료되었습니다.');
      setLoading(false);
      if (onComplete) onComplete();
    } catch (error) {
      setLoading(false);
      console.error('Ban submit error:', error);
      alert('제재 처리 실패: ' + (error.response?.data?.error || error.message || error));
    }
  };

  // JSX 반환
return (
  <form
    onSubmit={handleSubmit}
    className="admin resonos-card p-3 mb-3"
  >
    <select
      className="form-select mb-2"
      value={type}
      onChange={(e) => setType(e.target.value)}
      required
      disabled={loading}
    >
      <option value="">제재 유형 선택</option>
      <option value="warning">경고 (Warning)</option>
      <option value="suspension">정지 (Suspension)</option>
      <option value="ban">영구 제재 (Ban)</option>
    </select>

    <label htmlFor="startAt" className="form-label">시작일</label>
    <input
      id="startAt"
      type="datetime-local"
      className="form-control mb-2"
      value={startAt}
      onChange={(e) => setStartAt(e.target.value)}
      required
      disabled={loading}
    />

    <label htmlFor="endAt" className="form-label">종료일 (선택)</label>
    <input
      id="endAt"
      type="datetime-local"
      className="form-control mb-2"
      value={endAt}
      onChange={(e) => setEndAt(e.target.value)}
      disabled={loading}
    />

    <textarea
      className="form-control mb-2"
      placeholder="제재 사유를 입력하세요 (필수)"
      required
      value={banReason}
      onChange={(e) => setBanReason(e.target.value)}
      style={{ height: '64px' }}
      disabled={loading}
    />

    <div className="text-end">
      <button type="submit" className="btn btn-outline-danger btn-sm me-2" disabled={loading}>
        {loading ? '처리중...' : '제재'}
      </button>
      <button
        type="button"
        className="btn btn-outline-gold btn-sm"
        onClick={onCancel}
        disabled={loading}
      >
        취소
      </button>
    </div>
  </form>
);

};

export default BanMemberForm;
