import React, { useState, useEffect } from 'react';

import AddMemberForm from '../../components/admin/second/AddMemberForm';
import SearchForm from '../../components/admin/first/SearchForm';
import TableColumnHeader from '../../components/admin/first/TableColumnHeader';
import TableContent from '../../components/admin/first/TableContent';
import { list, insert, update, toggleEnable, banUser, remove, select } from '../../apis/admin'; // 필요한 API 함수 imports

const AdminMembersContainer = () => {
  const [members, setMembers] = useState([]);
  const [pagination, setPagination] = useState({ index: 0 });
  const [keyword, setKeyword] = useState('');
  const [loading, setLoading] = useState(false);
  const [showAddForm, setShowAddForm] = useState(false);

  // 상세보기 관련 상태
  const [detailMemberId, setDetailMemberId] = useState(null);
  const [detailMemberData, setDetailMemberData] = useState(null);

  // 제재 폼 나타낼 멤버 ID, 제재 사유 상태
  const [banFormUserId, setBanFormUserId] = useState(null);
  const [banReason, setBanReason] = useState('');

  const columns = [
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
  ];

  const fetchMembers = async (page = 1, size = 10, kw = '') => {
    setLoading(true);
    try {
      const response = await list(page, size, kw);
      const data = response.data;
      setMembers(data.content || data.members || []);
      setPagination({ index: data.number || page - 1, totalPages: data.totalPages });
    } catch (error) {
      console.error('멤버 목록 조회 실패', error);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchMembers(1, 10, keyword);
  }, [keyword]);

  const handleShowDetail = async (memberId) => {
    if (detailMemberId === memberId) {
      setDetailMemberId(null);
      setDetailMemberData(null);
    } else {
      try {
        const response = await select(memberId);
        let detail = response.data;
        detail.auth = detail.authList && detail.authList.length > 0 ? detail.authList[0] : '';
        setDetailMemberId(memberId);
        setDetailMemberData(detail);
      } catch (e) {
        alert('회원 정보를 찾을 수 없습니다.');
      }
    }
  };

  const handleDetailChange = (e) => {
    const { name, value } = e.target;
    if (name === 'auth') {
      setDetailMemberData(prev => ({
        ...prev,
        auth: value,
        authList: [{ auth: value }],
      }));
    } else if (name === 'enabled' || name === 'isPro') {
      setDetailMemberData(prev => ({
        ...prev,
        [name]: value === 'true',
      }));
    } else {
      setDetailMemberData(prev => ({
        ...prev,
        [name]: value,
      }));
    }
  };

  const handleDetailSubmit = async (e) => {
    e.preventDefault();
    try {
      const payload = {
        ...detailMemberData,
        authList:
          detailMemberData.authList && detailMemberData.authList.length > 0
            ? detailMemberData.authList
            : [{ auth: 'ROLE_USER' }],
      };
      await update(payload);
      alert('저장되었습니다.');
      setDetailMemberId(null);
      setDetailMemberData(null);
      fetchMembers(pagination.index + 1, 10, keyword);
    } catch (e) {
      alert('저장 실패: ' + (e.response?.data || e.message));
    }
  };

  const handleDelete = async () => {
    if (!window.confirm('정말 삭제하시겠습니까?')) return;
    try {
      await remove(detailMemberId);
      alert('삭제되었습니다.');
      setDetailMemberId(null);
      setDetailMemberData(null);
      fetchMembers(pagination.index + 1, 10, keyword);
    } catch (e) {
      alert('삭제 실패: ' + (e.response?.data || e.message));
    }
  };

  const handleToggleEnable = async (memberId, newEnabled) => {
    try {
      await toggleEnable(memberId, newEnabled);
      fetchMembers(pagination.index + 1, 10, keyword);
    } catch (error) {
      console.error('활성/비활성 토글 실패', error);
    }
  };

  // 제재 폼 토글 함수
  const toggleBanForm = (userId) => {
    if (banFormUserId === userId) {
      setBanFormUserId(null);
      setBanReason('');
    } else {
      setBanFormUserId(userId);
      setBanReason('');
    }
  };

  const handleBanReasonChange = (e) => {
    setBanReason(e.target.value);
  };

  // 제재 폼 제출
  const handleBanSubmit = async (e, userId) => {
    e.preventDefault();
    if (!banReason.trim()) {
      alert('제재 사유를 입력하세요.');
      return;
    }
    if (!window.confirm('정말 제재하시겠습니까?')) return;

    try {
      await banUser(userId, true, banReason);
      alert('제재 처리되었습니다.');
      setBanFormUserId(null);
      setBanReason('');
      fetchMembers(pagination.index + 1, 10, keyword);
    } catch (error) {
      alert('제재 처리 실패: ' + (error.message || error));
    }
  };

  const handleBanCancel = () => {
    setBanFormUserId(null);
    setBanReason('');
  };

  const handleBanToggle = async (memberId, ban) => {
    try {
      await banUser(memberId, ban);
      fetchMembers(pagination.index + 1, 10, keyword);
    } catch (error) {
      console.error('제재 토글 실패', error);
    }
  };

  const handleKeywordChange = (kw) => {
    setKeyword(kw);
  };

  const handleAddSubmit = async (formData) => {
    try {
      await insert(formData);
      setShowAddForm(false);
      fetchMembers(1, 10, keyword);
    } catch (error) {
      console.error('회원 등록 실패', error);
    }
  };

  const handleAddToggle = () => {
    setShowAddForm((prev) => !prev);
  };

  return (
    <div>
      {!showAddForm && (
        <button className="btn btn-gold btn-sm mb-3" onClick={handleAddToggle}>
          회원 등록
        </button>
      )}
      {showAddForm && <AddMemberForm onSubmit={handleAddSubmit} onCancel={handleAddToggle} />}
      <SearchForm onSearch={handleKeywordChange} />
      {loading ? (
        <div>로딩중...</div>
      ) : (
        <>
          <TableColumnHeader columns={columns} />
          <TableContent
            members={members}
            pagination={pagination}
            keyword={keyword}
            onToggleEnable={handleToggleEnable}
            onBanToggle={handleBanToggle}
            onShowDetail={handleShowDetail}
            renderExtraActions={(member) => (
              <div>
                <button
                  className="btn btn-danger btn-sm mb-2"
                  onClick={() => toggleBanForm(member.id)}
                >
                  제재
                </button>
                {banFormUserId === member.id && (
                  <form
                    onSubmit={(e) => handleBanSubmit(e, member.id)}
                    style={{
                      background: '#222',
                      padding: '20px 15px',
                      borderRadius: '7px',
                      marginBottom: '15px',
                    }}
                  >
                    <textarea
                      className="form-control mb-2"
                      placeholder="제재 사유를 입력하세요 (필수)"
                      required
                      value={banReason}
                      onChange={handleBanReasonChange}
                      style={{ height: '64px', color: 'white', background: '#333' }}
                    />
                    <div className="text-end">
                      <button type="submit" className="btn btn-danger btn-sm me-2">
                        제재
                      </button>
                      <button
                        type="button"
                        className="btn btn-outline-gold btn-sm"
                        onClick={handleBanCancel}
                      >
                        취소
                      </button>
                    </div>
                  </form>
                )}
              </div>
            )}
          />

          {detailMemberData && detailMemberId && (
            <div className="detail-info mt-3 p-3 border rounded bg-light text-dark">
              <h5>회원 상세 정보</h5>
              <form onSubmit={handleDetailSubmit}>
                <div className="mb-2">
                  <label>아이디:</label>
                  <input
                    type="text"
                    name="username"
                    value={detailMemberData.username || ''}
                    onChange={handleDetailChange}
                    required
                    autoComplete="off"
                  />
                </div>
                <div className="mb-2">
                  <label>닉네임:</label>
                  <input
                    type="text"
                    name="nickname"
                    value={detailMemberData.nickname || ''}
                    onChange={handleDetailChange}
                    required
                    autoComplete="off"
                  />
                </div>
                <div className="mb-2">
                  <label>이메일:</label>
                  <input
                    type="email"
                    name="email"
                    value={detailMemberData.email || ''}
                    onChange={handleDetailChange}
                    required
                    autoComplete="off"
                  />
                </div>
                <div className="mb-2">
                  <label>비밀번호 (변경시만 입력):</label>
                  <input
                    type="password"
                    name="password"
                    value={detailMemberData.password || ''}
                    onChange={handleDetailChange}
                    placeholder="변경할 비밀번호를 입력하세요"
                    autoComplete="new-password"
                  />
                </div>
                <div className="mb-2">
                  <label>프로필 이미지 URL:</label>
                  <input
                    type="text"
                    name="profileImage"
                    value={detailMemberData.profileImage || ''}
                    onChange={handleDetailChange}
                    autoComplete="off"
                  />
                  {detailMemberData.profileImage && (
                    <img
                      src={detailMemberData.profileImage}
                      alt="프로필"
                      style={{ maxWidth: '100px', marginTop: '5px' }}
                    />
                  )}
                </div>
                <div className="mb-2">
                  <label>소개(Bio):</label>
                  <textarea
                    name="bio"
                    value={detailMemberData.bio || ''}
                    onChange={handleDetailChange}
                    rows={3}
                    style={{ width: '100%' }}
                    placeholder="간단한 소개를 입력하세요"
                  />
                </div>
                <div className="mb-2">
                  <label>전문가 여부(isPro):</label>
                  <select
                    name="isPro"
                    value={detailMemberData.isPro ? 'true' : 'false'}
                    onChange={(e) =>
                      setDetailMemberData((prev) => ({
                        ...prev,
                        isPro: e.target.value === 'true',
                      }))
                    }
                  >
                    <option value="true">예</option>
                    <option value="false">아니오</option>
                  </select>
                </div>
                <div className="mb-2">
                  <label>상태:</label>
                  <select
                    name="enabled"
                    value={detailMemberData.enabled ? 'true' : 'false'}
                    onChange={(e) =>
                      setDetailMemberData((prev) => ({
                        ...prev,
                        enabled: e.target.value === 'true',
                      }))
                    }
                  >
                    <option value="true">정상</option>
                    <option value="false">휴면</option>
                  </select>
                </div>
                <div className="mb-2">
                  <label>권한:</label>
                  <select
                    name="auth"
                    value={detailMemberData.auth || ''}
                    onChange={handleDetailChange}
                  >
                    <option value="ROLE_USER">일반</option>
                    <option value="ROLE_ADMIN">운영자</option>
                  </select>
                </div>
                <div className="mb-2">
                  <label>Provider:</label>
                  <input
                    type="text"
                    name="provider"
                    value={detailMemberData.provider || ''}
                    onChange={handleDetailChange}
                    autoComplete="off"
                  />
                </div>
                <div className="mb-2">
                  <label>Provider ID:</label>
                  <input
                    type="text"
                    name="providerId"
                    value={detailMemberData.providerId || ''}
                    onChange={handleDetailChange}
                    autoComplete="off"
                  />
                </div>

                {/* 제재 내역 출력 (있으면 리스트로) */}
                <div className="mb-2">
                  <label>제재 내역:</label>
                  {detailMemberData.sanctions && detailMemberData.sanctions.length > 0 ? (
                    <ul style={{ maxHeight: '150px', overflowY: 'auto', paddingLeft: '20px' }}>
                      {detailMemberData.sanctions.map((sanction, idx) => (
                        <li key={idx}>
                          {sanction.reason} ({new Date(sanction.date).toLocaleDateString()})
                        </li>
                      ))}
                    </ul>
                  ) : (
                    <p>제재 내역이 없습니다.</p>
                  )}
                </div>

                <div className="text-end">
                  <button type="submit" className="btn btn-gold btn-sm me-2">
                    저장
                  </button>
                  <button
                    type="button"
                    className="btn btn-outline-secondary btn-sm me-2"
                    onClick={() => {
                      setDetailMemberId(null);
                      setDetailMemberData(null);
                    }}
                  >
                    닫기
                  </button>
                  <button
                    type="button"
                    className="btn btn-outline-danger btn-sm"
                    onClick={handleDelete}
                  >
                    삭제
                  </button>
                </div>
              </form>
            </div>
          )}
        </>
      )}
    </div>
  );
};

export default AdminMembersContainer;
