import React from 'react'
import styles from '../css/admin.module.css'

const MenuCard = ({ title, link, label }) => {
  return (
    <div className="col-md-3">
      <div className={styles['resonos-card']}>
        <div className="card-sm-title card-title">{title}</div>
        <a href={link} className="btn btn-sm mt-2 btn-outline-gold">
          {label}
        </a>
      </div>
    </div>
  )
}

export default MenuCard