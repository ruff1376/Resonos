import React, { useEffect, useState } from 'react';
import {
  getRoleMemberList,
  addUserAuth,
  deleteUserAuth,
  toggleAdminRole,
  updateUserAuths
} from '../../apis/admin';
import Pagination from '../../components/admin/Pagination';
import SearchForm from '../../components/admin/first/SearchForm';
import QuickMenu from '../../components/admin/first/QuickMenu';


const AdminRoleManageContainer = () => {
  const [members, setMembers] = useState([]);
  const [pagination, setPagination] = useState({ page: 1, size: 10, totalPages: 1 });
  const [loading, setLoading] = useState(false);
  const [page, setPage] = useState(1);
  const [keyword, setKeyword] = useState('');

  const fetchMembers = async (pageNum = 1, size = 10, kw = '') => {
    setLoading(true);
    try {
      const res = await getRoleMemberList(pageNum, size, kw);
      const data = res.data;
      setMembers(data.members || []);
      if (data.pagination) {
        setPagination({
          page: data.pagination.page,
          size: data.pagination.size,
          totalPages: Math.ceil(data.pagination.total / data.pagination.size)
        });
      }
    } catch (e) {
      console.error('권한 목록 조회 실패', e);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchMembers(1, pagination.size, keyword);
  }, [keyword]);

  const onPageChange = (newPage) => {
    setPage(newPage);
    fetchMembers(newPage, pagination.size, keyword);
  };

  const handleSearch = (kw) => {
    setKeyword(kw);
  };

  // 권한 추가/삭제/토글/일괄저장
  const handleAddAuth = async (username, auth) => {
    try {
      await addUserAuth(username, auth);
      fetchMembers(page, pagination.size, keyword);
    } catch {
      alert('권한 추가 실패');
    }
  };

  const handleDeleteAuth = async (username, auth) => {
    if (!window.confirm('정말 삭제하시겠습니까?')) return;
    try {
      await deleteUserAuth(username, auth);
      fetchMembers(page, pagination.size, keyword);
    } catch {
      alert('권한 삭제 실패');
    }
  };

  const handleToggleAdmin = async (username, grant) => {
    try {
      await toggleAdminRole(username, grant);
      fetchMembers(page, pagination.size, keyword);
    } catch {
      alert('토글 실패');
    }
  };

  const handleBulkSave = async (bulkData) => {
    try {
      for (const [username, auths] of Object.entries(bulkData)) {
        await updateUserAuths(username, auths);
      }
      alert('일괄 저장 완료');
      fetchMembers(page, pagination.size, keyword);
    } catch {
      alert('일괄 저장 실패');
    }
  };

  return (
    <div>
      <h2 className="mb-4 text-light-gold">권한/역할 관리</h2>

      <SearchForm onSearch={handleSearch} placeholder="닉네임 또는 이메일 검색" />

      {loading ? (
        <div>로딩중...</div>
      ) : (
        <>
          {/* 권한 추가/삭제 */}
          <div className="resonos-card p-4 mb-4">
            <table className="table table-dark table-hover align-middle">
              <thead>
                <tr>
                  <th>번호</th>
                  <th>닉네임</th>
                  <th>이메일</th>
                  <th>현재 권한</th>
                  <th>권한 추가</th>
                  <th>권한 삭제</th>
                </tr>
              </thead>
              <tbody>
                {members.length > 0 ? members.map((m, idx) => (
                  <tr key={m.username}>
                    <td>{(page - 1) * pagination.size + idx + 1}</td>
                    <td>{m.nickname}</td>
                    <td>{m.email}</td>
                    <td>
                      {m.authList?.map((auth, ai) => (
                        <span
                          key={ai}
                          className={`badge me-1 ${auth.auth === 'ROLE_ADMIN' ? 'bg-gold' : 'bg-secondary'}`}
                        >
                          {auth.auth === 'ROLE_ADMIN' ? '운영자' : '일반'}
                        </span>
                      ))}
                    </td>
                    <td>
                      <div className="d-flex gap-2">
                        <select className="form-select form-select-sm" defaultValue="ROLE_USER" id={`addAuth_${m.username}`}>
                          <option value="ROLE_USER">일반</option>
                          <option value="ROLE_ADMIN">운영자</option>
                        </select>
                        <button
                          className="btn btn-gold btn-sm"
                          onClick={() => {
                            const selectEl = document.getElementById(`addAuth_${m.username}`);
                            handleAddAuth(m.username, selectEl.value);
                          }}
                        >추가</button>
                      </div>
                    </td>
                    <td>
                      <div className="d-flex gap-2">
                        <select className="form-select form-select-sm" id={`delAuth_${m.username}`}>
                          {m.authList?.map((auth, ai) => (
                            <option key={ai} value={auth.auth}>
                              {auth.auth === 'ROLE_ADMIN' ? '운영자' : '일반'}
                            </option>
                          ))}
                        </select>
                        <button
                          className="btn btn-outline-danger btn-sm"
                          onClick={() => {
                            const selectEl = document.getElementById(`delAuth_${m.username}`);
                            handleDeleteAuth(m.username, selectEl.value);
                          }}
                        >삭제</button>
                      </div>
                    </td>
                  </tr>
                )) : (
                  <tr><td colSpan="6" className="text-center text-secondary">등록된 회원이 없습니다.</td></tr>
                )}
              </tbody>
            </table>
          </div>

          {/* ROLE_ADMIN 토글 */}
          <div className="mt-4">
            <h4 className="text-light-gold">운영자 권한 토글</h4>
            <table className="table table-dark table-hover align-middle">
              <thead>
                <tr>
                  <th>아이디</th>
                  <th>닉네임</th>
                  <th>운영자 권한</th>
                </tr>
              </thead>
              <tbody>
                {members.length > 0 ? members.map(m => (
                  <tr key={m.username}>
                    <td>{m.username}</td>
                    <td>{m.nickname}</td>
                    <td>
                      <input
                        type="checkbox"
                        checked={m.authList?.some(a => a.auth === 'ROLE_ADMIN')}
                        onChange={e => handleToggleAdmin(m.username, e.target.checked)}
                      /> 운영자
                    </td>
                  </tr>
                )) : (
                  <tr><td colSpan="3" className="text-center text-secondary">없음</td></tr>
                )}
              </tbody>
            </table>
          </div>

          {/* 일괄 수정 */}
          <div className="mt-4">
            <h4 className="text-light-gold">일괄 권한 수정</h4>
            <form onSubmit={e => {
              e.preventDefault();
              const bulkData = {};
              members.forEach(m => {
                const checks = document.querySelectorAll(`input[name='auths_${m.username}']:checked`);
                bulkData[m.username] = Array.from(checks).map(c => c.value);
              });
              handleBulkSave(bulkData);
            }}>
              <table className="table table-dark table-hover align-middle">
                <thead>
                  <tr>
                    <th>아이디</th>
                    <th>닉네임</th>
                    <th>일반</th>
                    <th>운영자</th>
                  </tr>
                </thead>
                <tbody>
                  {members.length > 0 ? members.map(m => (
                    <tr key={m.username}>
                      <td>{m.username}</td>
                      <td>{m.nickname}</td>
                      <td>
                        <input type="checkbox" name={`auths_${m.username}`} value="ROLE_USER"
                          defaultChecked={m.authList?.some(a => a.auth === 'ROLE_USER')} />
                      </td>
                      <td>
                        <input type="checkbox" name={`auths_${m.username}`} value="ROLE_ADMIN"
                          defaultChecked={m.authList?.some(a => a.auth === 'ROLE_ADMIN')} />
                      </td>
                    </tr>
                  )) : (
                    <tr><td colSpan="4" className="text-center text-secondary">없음</td></tr>
                  )}
                </tbody>
              </table>
              <button className="btn btn-gold btn-sm" type="submit">일괄 저장</button>
            </form>
          </div>

          {/* 페이징 */}
          <Pagination
            page={page}
            first={1}
            last={pagination.totalPages}
            prev={page > 1 ? page - 1 : 1}
            next={page < pagination.totalPages ? page + 1 : pagination.totalPages}
            start={Math.max(1, page - 4)}
            end={Math.min(pagination.totalPages, page + 5)}
            pageUri={`/admin/role`}
            onPageChange={onPageChange}
          />
        </>
      )}
      <QuickMenu />
    </div>
  );
};

export default AdminRoleManageContainer;
