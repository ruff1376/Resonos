import React from 'react';
import AdminMembersContainer from '../../containers/admin/AdminMembersContainer';
import styles from '../../components/admin/css/Admin.module.css'

const AdminMembersPage = () => {
  return (
    <>
  <div className="container">
        <h2>Admin Dashboard</h2>
        <AdminMembersContainer />
      </div>
    </>
  )
}

export default AdminMembersPage