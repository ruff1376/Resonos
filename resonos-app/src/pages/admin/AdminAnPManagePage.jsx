import React from 'react'
import AdminAnPManageContainer from '../../containers/admin/AdminAnPManageContainer';
import styles from '../../components/admin/css/Admin.module.css'

const AdminAnPManagePage = () => {
  return (
    <>
    <div className={styles['container']}>
      <AdminAnPManageContainer />
    </div>
    </>
    
  )
}

export default AdminAnPManagePage