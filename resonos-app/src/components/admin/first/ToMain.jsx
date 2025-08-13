import React from 'react'
import AdminContainer from '../../../containers/admin/AdminContainer'

const ToMain = () => {
  return (
    // /admin 으로 이동하는 거로 AdminContainer.jsx
    // <div className="admin container">
    <>
      <div className="admin container">
        <a href="/admin" className="quick-menu-item">메인으로</a>
      </div>
    </>
  )
}

export default ToMain