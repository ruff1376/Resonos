import React from 'react'
import { useLocation } from "react-router-dom";
import MemberLogContainer from '../../containers/admin/MemberLogContainer'
import styles from '../../components/admin/css/Admin.module.css'

const AdminMemberDetail = () => {

  const location = useLocation();
  const queryParams = new URLSearchParams(location.search);
  const userId = Number(queryParams.get("userId"));

  return (
  <div className="admin container">
      {/* userId를 MemberLogContainer에 전달 */}
      <MemberLogContainer userId={userId} />
      {/* 기타 상세 컴포넌트 내용 */}
    </div>
  );
};

export default AdminMemberDetail