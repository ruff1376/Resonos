import React from 'react';
import AdminMembersContainer from '../../containers/admin/AdminMembersContainer';

const AdminMembersPage = () => {
  return (
    <>
  <div className="admin container">
        <h2>Admin Dashboard</h2>
        <AdminMembersContainer />
      </div>
    </>
  )
}

export default AdminMembersPage