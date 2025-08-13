import React from 'react'
import AdminRoleManageContainer from '../../containers/admin/AdminRoleManageContainer';
import styles from '../../components/admin/css/Admin.module.css'

const AdminRoleManagePage = () => {
  return (
    <>
    <div className={styles['container']}>
      <AdminRoleManageContainer/>
    </div>
    </>
    
  )
}

export default AdminRoleManagePage