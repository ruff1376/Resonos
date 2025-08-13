import React from 'react'
import BadgeUsersContainer from '../../containers/admin/BadgeUsersContainer';
import styles from '../../components/admin/css/Admin.module.css'

const BadgeUsersPage = () => {
  return (
    <>
    <div className={styles['container']}>
      <BadgeUsersContainer />
    </div>
    </>
  )
}

export default BadgeUsersPage

