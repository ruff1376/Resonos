import React from 'react'
import AdminAnPManageContainer from '../../containers/admin/AdminAnPManageContainer';
import styles from '../../components/admin/css/Admin.module.css'
import QuickMenu from '../../components/admin/first/QuickMenu';

const AdminAnPManagePage = () => {
  return (
    <>
    <div className="admin container">
      <AdminAnPManageContainer />
      <QuickMenu/>
    </div>
    </>
  )
}

export default AdminAnPManagePage