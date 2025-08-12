import React from 'react'
import MypageTab from './MypageTab'
import NotificationCard from './card/NotificationCard'

const SetNotification = ({notiList, notiType, lastPath, onToggleNoti}) => {

  return (
    <main className="con con-alaram position-relative">
      <MypageTab lastPath={lastPath}/>

      {/* 알림 설정 섹션 */}
      <section className="info-wrapper">
        <div className="info-section">
          <div className="title">
            <div>
              <h2 className="text-start">알림 설정</h2>
            </div>
          </div>

          <ul className="ul-list">
            {notiList.map((noti, index) => (
              <NotificationCard
                key={index}
                noti={noti}
                notiType={notiType}
                onToggleNoti={onToggleNoti}
              />
            ))}
          </ul>
        </div>
      </section>
    </main>
  )
}

export default SetNotification