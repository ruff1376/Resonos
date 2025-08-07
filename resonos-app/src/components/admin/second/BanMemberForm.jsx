import React, { useState } from 'react';
import { banUser } from '../../../apis/admin'; // banUser API 호출 함수

const BanMemberForm = ({ userId, onComplete, onCancel }) => {
  const [banReason, setBanReason] = useState('');
  const [loading, setLoading] = useState(false);

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!banReason.trim()) {
      alert('제재 사유를 입력하세요.');
      return;
    }
    if (!window.confirm('정말 제재하시겠습니까?')) return;

    try {
      setLoading(true);
      const response = await banUser(userId, true, banReason);
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

  return (
    <form
      onSubmit={handleSubmit}
      style={{ background: '#222', padding: '20px 15px', borderRadius: '7px', marginBottom: '15px' }}
    >
      <textarea
        className="form-control mb-2"
        placeholder="제재 사유를 입력하세요 (필수)"
        required
        value={banReason}
        onChange={e => setBanReason(e.target.value)}
        style={{ height: '64px', color: 'white', background: '#333' }}
        disabled={loading}
      />
      <div className="text-end">
        <button type="submit" className="btn btn-danger btn-sm me-2" disabled={loading}>
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
