import React from 'react'
import AdminNoticeContainer from '../../containers/admin/AdminNoticeContainer';
import styles from '../../components/admin/css/Admin.module.css'

const AdminNoticePage = () => {
  return (
    <>
        <div className={styles['container']}>
            <AdminNoticeContainer/>
        </div>
    </>
  )
}

export default AdminNoticePage





