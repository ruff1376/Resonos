import React, { useState, useEffect } from 'react';

import AddMemberForm from '../../components/admin/second/AddMemberForm';
import SearchForm from '../../components/admin/first/SearchForm';
import TableColumnHeader from '../../components/admin/first/TableColumnHeader';
import TableContent from '../../components/admin/first/TableContent'; // 수정 예정
import { list, insert, update, toggleEnable, banUser, remove, select } from '../../apis/admin';
import MemberDetailForm from '../../components/admin/second/MemberDetailForm';

import Pagination from '../../components/admin/Pagination';

const AdminMembersContainer = () => {
  const [members, setMembers] = useState([]);
  const [pagination, setPagination] = useState({ index: 0 });
  const [keyword, setKeyword] = useState('');
  const [loading, setLoading] = useState(false);
  const [showAddForm, setShowAddForm] = useState(false);

  // 상세보기 관련 상태
  const [detailMemberId, setDetailMemberId] = useState(null);
  const [detailMemberData, setDetailMemberData] = useState(null);
  // 상세 - 수정시 일부만 업데이트 처리 
  const [originalDetailMemberData, setOriginalDetailMemberData] = useState(null);
  // 일부 수정 확인 컬럼 들 
  const requiredFields = [
    'username',
    'email',
    'password',      // 비밀번호도 null이면 안 되면 포함
    'nickname',
    'profileImage',  // DB 컬럼명이 profile_image라면 JS에서는 profileImage
    'bio',
    'isPro',         // is_pro
    'enabled',
    'provider',
    'providerId'     // provider_id
  ];

  // 페이지네이션
  const [page, setPage] = useState(1);
  const startPage = Math.max(1, page - 4);
  const endPage = Math.min(pagination.totalPages || 1, page + 5);
  const pageUri = `/admin/members?keyword=${encodeURIComponent(keyword)}`;


 const onPageChange = (newPage) => {
  if (newPage === page) return; // 동일 페이지 요청 방지
  setPage(newPage);
  fetchMembers(newPage, 10, keyword);
};

  // 제재 폼 상태는 TableContent 내부로 이전 예정
  // const [banFormUserId, setBanFormUserId] = useState(null);

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
    
    console.log('멤버 목록 API 응답:', data); // 응답 전체 확인용
    
    // members 배열 설정 (members 또는 content 키 중 존재하는 값으로)
    setMembers(data.members || data.content || []);
    
    // pagination 정보가 data.pagination 안에 있으므로 해당 필드 활용
    const p = data.pagination || {};
    
    // totalPages 계산: total(전체 항목수) / size(페이지당 개수)
    const totalPages = p.size && p.total ? Math.ceil(p.total / p.size) : 1;
    
    setPagination({
      page: typeof p.page === 'number' ? p.page : page, // API가 1-based 인지 확인 필요
      size: typeof p.size === 'number' ? p.size : size,
      total: typeof p.total === 'number' ? p.total : 0,
      totalPages: totalPages,
    });
  } catch (error) {
    console.error('멤버 목록 조회 실패', error);
  } finally {
    setLoading(false);
  }
};



  useEffect(() => {
    setPage(1);  // 검색어 변경 시 page 1로 초기화
    fetchMembers(1, 10, keyword);
  }, [keyword]);

  const handleShowDetail = async (memberId) => {
    if (detailMemberId === memberId) {
      setDetailMemberId(null);
      setDetailMemberData(null);
      setOriginalDetailMemberData(null);      // 상세 닫는 경우 원본 초기화
    } else {
      try {
        const response = await select(memberId);
        let detail = response.data;
        detail.auth = detail.authList && detail.authList.length > 0 ? detail.authList[0] : '';
        setDetailMemberId(memberId);
        setDetailMemberData(detail);
        setOriginalDetailMemberData(detail);  // 상세 열 때 원본 저장
      } catch (e) {
        alert('회원 정보를 찾을 수 없습니다.');
      }
    }
  };

  // 상세 - 변경된 필드만 추출 함수
  const getChangedFields = (original, current) => {
  const changed = {};
  Object.keys(current).forEach(key => {
    if (JSON.stringify(current[key]) !== JSON.stringify(original[key])) {
      changed[key] = current[key];
    }
  });
  return changed;
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
  if (!originalDetailMemberData) return;

  const changedFields = getChangedFields(originalDetailMemberData, detailMemberData);

  // 필수 필드는 항상 포함
  requiredFields.forEach(field => {
    if (!(field in changedFields)) {
      changedFields[field] = detailMemberData[field] ?? originalDetailMemberData[field];
    }
  });

  if (Object.keys(changedFields).length === 0) {
    alert('변경된 내용이 없습니다.');
    return;
  }

  if ('auth' in changedFields) {
    // user_auth 테이블은 username, auth만 필요 (UserMapper.xml updateAuth 참고)
    changedFields.authList = [{
      username: detailMemberData.username,
      auth: changedFields.auth
    }];
    delete changedFields.auth;
  }

  try {
    await update({ id: detailMemberData.id, ...changedFields });
    alert('저장되었습니다.');
    setDetailMemberId(null);
    setDetailMemberData(null);
    setOriginalDetailMemberData(null);
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
      setMembers(prev =>
        prev.map(m => (m.id === memberId ? { ...m, enabled: newEnabled } : m))
      );
    } catch (error) {
      console.error('활성/비활성 토글 실패', error);
    }
  };
  // 검색 키워드 감지
  const handleKeywordChange = (kw) => {
    setKeyword(kw);
  };
  // 회원 추가
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

    // 추가: 제재 토글 핸들러
  const handleBanToggle = async (memberId, ban, reason = '') => {
    try {
      // banUser API 호출
      await banUser(memberId, ban, reason);
      
      // 상태 업데이트: ban 상태 최신화
      setMembers(prev =>
        prev.map(m => (m.id === memberId ? { ...m, ban } : m))
      );
      
      alert(ban ? '제재 처리 되었습니다.' : '제재 해제 되었습니다.');
      
      // 필요한 경우 목록 다시 받기
      fetchMembers(pagination.index + 1, 10, keyword);

      // 제재 폼 닫기 등의 추가 상태 처리 필요 시 여기에
    } catch (error) {
      alert('제재 처리 실패: ' + (error.response?.data || error.message || error));
      console.error('banToggle error', error);
    }
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
            setMembers={setMembers}
            pagination={pagination}
            keyword={keyword}
            onToggleEnable={handleToggleEnable}
            onShowDetail={handleShowDetail}
            onBanToggle={handleBanToggle}
            detailMemberId={detailMemberId}
            detailMemberData={detailMemberData}
            onDetailChange={handleDetailChange}
            onDetailSubmit={handleDetailSubmit}
            onDelete={handleDelete}
            onCloseDetail={() => {
              setDetailMemberId(null);
              setDetailMemberData(null);
              setOriginalDetailMemberData(null);
            }}
          />
            <Pagination
              page={page}
              first={1}
              last={pagination.totalPages || 1}             // totalPages가 유효하지 않을 시 1로 기본
              prev={page > 1 ? page - 1 : 1}
              next={page < (pagination.totalPages || 1) ? page + 1 : (pagination.totalPages || 1)}
              start={startPage}
              end={endPage}
              pageUri={pageUri}
              onPageChange={onPageChange}
            />
        </>
      )}
    </div>
  );
};

export default AdminMembersContainer;
