import React from 'react'
import VoteStatsContainer from '../../containers/admin/VoteStatsContainer';
import styles from '../../components/admin/css/Admin.module.css'

const VoteStatsPage = () => {
  return (
    <>
        <div className={styles['container']}>
            <VoteStatsContainer></VoteStatsContainer>
        </div>
    </>
  )
}

export default VoteStatsPage

