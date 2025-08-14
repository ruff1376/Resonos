import React from 'react'
import './index.css'
import BoardListCard from './card/BoardListCard'
import BoardRankingCard from './card/BoardRankingCard'
import BoardTitleCard from './card/BoardTitleCard'

const Index = () => {
  return (
    <main className='com index'>
      <div className="left">
        {/* 주요 소식 */}
        <div className='main-news'>
          <h2>주요 소식</h2>
          <div>
            <img width="200px" height="150px" src="/img/profileImg.png" alt="썸네일" />
          </div>
          <div>
            <img width="200px" height="150px" src="/img/profileImg.png" alt="썸네일" />
          </div>
        </div>
        {/* 최신글 */}
        <div className='post-area'>
          <h3>최신글</h3>
          <ul>
            <BoardListCard title={'최근 게시글 제목'} />
            <BoardListCard title={'최근 게시글 제목'} />
            <BoardListCard title={'최근 게시글 제목'} />
            <BoardListCard title={'최근 게시글 제목'} />
            <BoardListCard title={'최근 게시글 제목'} />
          </ul>
        </div>
        {/* 인기글 */}
        <div className='post-area'>
          <h3>인기글</h3>
          <ul>
            <BoardListCard title={'인기 게시글 제목'} />
            <BoardListCard title={'인기 게시글 제목'} />
            <BoardListCard title={'인기 게시글 제목'} />
            <BoardListCard title={'인기 게시글 제목'} />
            <BoardListCard title={'인기 게시글 제목'} />
          </ul>
        </div>
        {/* 이미지 갤러리 */}
        <div className='post-area'>
          <h3>갤러리</h3>
          <ul>
            <BoardListCard title={'갤러리 게시글 제목'} />
            <BoardListCard title={'갤러리 게시글 제목'} />
            <BoardListCard title={'갤러리 게시글 제목'} />
            <BoardListCard title={'갤러리 게시글 제목'} />
            <BoardListCard title={'갤러리 게시글 제목'} />
          </ul>
        </div>
      </div>
      <div className="right">
        {/* 실시간 인기글 */}
        <div className='right-card'>
          <h3>실시간 인기글</h3>
          <ul>
            <BoardTitleCard title={'실기간 인기글 제목'} />
            <BoardTitleCard title={'실기간 인기글 제목'} />
            <BoardTitleCard title={'실기간 인기글 제목'} />
            <BoardTitleCard title={'실기간 인기글 제목'} />
            <BoardTitleCard title={'실기간 인기글 제목'} />
          </ul>
        </div>
        {/* 게시판 순위 */}
        <div className='right-card ranking'>
          <h3>게시판 순위 Top5</h3>
          <ul>
            <BoardRankingCard title={'게시판 이름'} rank={1} />
            <BoardRankingCard title={'게시판 이름'} rank={2} />
            <BoardRankingCard title={'게시판 이름'} rank={3} />
            <BoardRankingCard title={'게시판 이름'} rank={4} />
            <BoardRankingCard title={'게시판 이름'} rank={5} />
          </ul>
        </div>
        {/* 신설 게시판 */}
        <div className='right-card'>
          <h3>신설 게시판</h3>
          <ul>
            <BoardTitleCard title={'신설된 게시판 이름'} />
            <BoardTitleCard title={'신설된 게시판 이름'} />
            <BoardTitleCard title={'신설된 게시판 이름'} />
            <BoardTitleCard title={'신설된 게시판 이름'} />
            <BoardTitleCard title={'신설된 게시판 이름'} />
          </ul>
        </div>
      </div>
    </main>
  )
}

export default Index