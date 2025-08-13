import React from 'react'
import TagManageContainer from '../../containers/admin/TagManageContainer';
import styles from '../../components/admin/css/Admin.module.css'

const AdminTagManagePage = () => {
  return (
    <div className={styles.adminContainer}>
      <TagManageContainer />
    </div>
  )
}

export default AdminTagManagePage