import React from 'react'
import AdminNotificationContainer from '../../containers/admin/AdminNotificationContainer';
import styles from '../../components/admin/css/Admin.module.css'

const AdminNotificationPage = () => {
  return (
    <>
    <div className={styles['container']}>
      <AdminNotificationContainer/>
    </div>
    </>
  )
}

export default AdminNotificationPage