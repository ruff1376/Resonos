import React from 'react'
import MypageTab from './MypageTab'
import NotiLIstCard from './card/NotiLIstCard'

const Notification = ({lastPath, notiList, count, readAll, deleteAll, onToggleRead}) => {

  return (
    <main className='con con-noti position-relative'>
      <MypageTab lastPaht={lastPath}/>
      <section className="info-wrapper">
        <div className="info-section">
          <div className="title">
            <div>
              <h2 className="text-start">미확인 알림</h2>
              <span className="count">{count}</span>
            </div>
            <div>
              <button onClick={readAll}>전체 읽음</button>
              <button onClick={deleteAll}>전체 삭제</button>
            </div>
          </div>
          <ul className="ul-list">
            {(notiList == null || notiList.length === 0) && (
              <div className="empty-text">
                <p>알림이 없습니다.</p>
              </div>
            )}
            {notiList && notiList.map((noti) => (
              <NotiLIstCard
                noti={noti}
                key={noti.id}
                onToggleRead={onToggleRead}
              />
            ))}
          </ul>
        </div>
      </section>
    </main>
  )
}

export default Notification