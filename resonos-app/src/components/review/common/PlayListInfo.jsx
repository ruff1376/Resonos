import React from 'react'

const PlayListInfo = () => {
  return (
    <>
      <div className="info pl-list">
        <p id="subtitle">{`${album.title}💽의 트랙이 포함된 플리🎶`}</p>
        {emptyPlayList || playLists.length === 0 ? (
          <>
            <p>해당 음원을 포함한</p>
            <p>플레이리스트를 만들어보세요! 🤩</p>
          </>
        ) : (
          playLists.map((playList) => (
            <Link key={playList.id} to={`/playlists/${playList.id}`}>
              <p>{`${playList.title} ❤️${playList.likeCount}`}</p>
            </Link>
          ))
        )}
      </div>
    </>
  )
}

export default PlayListInfo