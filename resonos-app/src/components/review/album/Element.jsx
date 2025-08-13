import React from 'react'


const Element = () => {
  return (
    <>
      {/* 요소 투표 */}
      <div className="arg-card">
        <div className="chart">
          {isArgEmpty ? (
            <p id="headline">아직 아무도 투표하지 않았어요</p>
          ) : (
            <canvas id="hexRadarChart"></canvas>
          )}
        </div>
        <div className="arg-vote" data-album-id={album.id}>
          <div className="vote-header">
            <p id="headline">6요소 평가</p>
          </div>
          {/* 로그인 여부에 따른 투표 UI */}
          {!isAdmin ? (
            <p id="headline" style={{ paddingTop: '35px' }}>
              로그인후 점수투표가 가능합니다
            </p>
          ) : (
            <VoteForm albumId={album.id} userVote={userVote} />
          )}
        </div>
      </div>
      {/* 요소 투표 끝 */}
    </>
  )
}

export default Element