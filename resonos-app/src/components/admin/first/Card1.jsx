import React from 'react'
import styles from '../css/admin.module.css'
const card1 = ({ title, value}) => { 
  return (
    <>
    {/* <div className={styles['col-md-3']}>
      <div className={styles['resonos-card']}>
        <div className={styles['card-title']}>{title}</div>
        <div className={styles['card-value']}>{value}</div>
      </div>
    </div> */}
      <div className="col-md-3">
        <div className={styles['resonos-card']}>
          <div className="card-title">{title}</div>
          <div className="card-value">{value}</div>
        </div>
      </div>

    

    </>
  )
}

export default card1