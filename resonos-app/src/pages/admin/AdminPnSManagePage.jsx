import React from 'react'
import AdminPnSManageContainer from '../../containers/admin/AdminPnSManageContainer';
import styles from '../../components/admin/css/Admin.module.css'

const AdminPnSManagePage = () => {
  return (
    <>
    <div className={styles['container']}>
      <AdminPnSManageContainer/>
    </div>
    </>
    
  )
}

export default AdminPnSManagePage