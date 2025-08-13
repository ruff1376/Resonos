import React from 'react'
import AdminAnPManageContainer from '../../containers/admin/AdminAnPManageContainer';
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