import React from 'react';
import AdminContainer from '../../containers/admin/AdminContainer';
import styles from '../../components/admin/css/Admin.module.css'

const Index = () => {
  return (
  <>
  <div className="admin container">
      <h2>Admin Dashboard</h2>
      <AdminContainer />
    </div>
  </>
  );
}

export default Index