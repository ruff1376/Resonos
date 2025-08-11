import React from 'react'
import ReviewReportManageContainer from '../../containers/admin/ReviewReportManageContainer';
import styles from '../../components/admin/css/Admin.module.css'

const ReviewReportManagePage = () => {
  return (
    <>
        <div className={styles['container']}>
            <ReviewReportManageContainer />
        </div>
    </>
  )
}

export default ReviewReportManagePage



