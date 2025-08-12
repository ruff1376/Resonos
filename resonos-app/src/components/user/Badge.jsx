import React from 'react'
import MypageTab from './MypageTab'

const Badge = ({haveBadgeList, notHaveBadgeList, lastPath}) => {
  return (
    <main className="con con-badge position-relative">
      {/* 왼쪽 리모컨 */}
      <MypageTab lastPath={lastPath}/>

      {/* 획득 배지 */}
      <section className="info-wrapper">
        <div className="info-section">
          <div className="title">
            <div>
              <h2 className="text-start">획득한 배지</h2>
            </div>
          </div>

          {(!haveBadgeList || haveBadgeList.length === 0) && (
            <div className="empty-text">
              <p>획득한 배지가 없습니다.</p>
            </div>
          )}

          <ul className="ul-list bl d-flex">
            {haveBadgeList &&
              haveBadgeList.map((badge) => (
                <li key={badge.id}>
                  <div className="bg-badge">
                    <div className="badge">
                      <span>{badge.name}</span>
                    </div>
                    <p>{badge.description}</p>
                  </div>
                </li>
              ))}
          </ul>
        </div>
      </section>

      {/* 미획득 배지 */}
      <section className="info-wrapper">
        <div className="info-section">
          <div className="title">
            <div>
              <h2 className="text-start">미획득 배지</h2>
            </div>
          </div>

          {(!notHaveBadgeList || notHaveBadgeList.length === 0) && (
            <div className="empty-text">
              <p>회원님은 전설이십니다.</p>
            </div>
          )}

          <ul className="ul-list bl d-flex">
            {notHaveBadgeList &&
              notHaveBadgeList.map((badge) => (
                <li key={badge.id}>
                  <div className="bg-badge cg">
                    <div className="badge cg">
                      <span>{badge.name}</span>
                    </div>
                    <p>{badge.description}</p>
                  </div>
                </li>
              ))}
          </ul>
        </div>
      </section>
    </main>
  )
}

export default Badge