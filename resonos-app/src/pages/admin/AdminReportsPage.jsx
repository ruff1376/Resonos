import React from 'react'
import AdminReportsContainer from '../../containers/admin/AdminReportsContainer'
import styles from '../../components/admin/css/Admin.module.css'

const AdminReportsPage = () => {
  return (
    <>
  <div className="container">
        <h2>Admin Dashboard</h2>
        <AdminReportsContainer />
      </div>
    </>
  )
}

export default AdminReportsPage