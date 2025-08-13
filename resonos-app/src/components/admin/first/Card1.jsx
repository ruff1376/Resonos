import React from 'react'
const card1 = ({ title, value}) => { 
  return (
    <>
    {/* <div className={styles['col-md-3']}>
      <div className={styles['resonos-card']}>
        <div className={styles['card-title']}>{title}</div>
        <div className={styles['card-value']}>{value}</div>
      </div>
    </div> */}

    {/* 모든 classname에 admin 추가해 */}
      <div className="col-md-3">
        <div className="resonos-card">
          <div className="card-title">{title}</div>
          <div className="card-value">{value}</div>
        </div>
      </div>

    

    </>
  )
}

export default card1