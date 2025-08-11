import React from 'react'
import AdminBadgeManageContainer from '../../containers/admin/AdminBadgeManageContainer';
import styles from '../../components/admin/css/Admin.module.css'

const AdminBadgeManagePage = () => {
  return (
     <>
    <div className={styles['container']}>
      <AdminBadgeManageContainer/>
    </div>
    </>
  )
}

export default AdminBadgeManagePage