import React from 'react'

const TrackCard = ({track, isOwner, onDelete}) => {

  const handleDelete = () => {
    onDelete(track.orderNo)
  }

  return (
    <li className="list-item" key={track.id}>
      <input type="hidden" value={track.id} />
      <p className="order-no">{track.orderNo}</p>
      <img src={track.coverImage} className="follow-img" alt="트랙 커버" />
      <div className="info">
        <span className="name-album">{track.title}</span>
        <span className="name-artist">{track.artistName}</span>
      </div>
      {isOwner && (
        <div className="right">
          {track.liked && (
            <button type="button" className="like like-track">
              ♥
            </button>
          )}
          <button
            type="button"
            className="btn btn-danger"
            onClick={handleDelete}
          >
            삭제
          </button>
        </div>
      )}
    </li>
  )
}

export default TrackCard