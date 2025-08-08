import React from 'react'
import {MySwal} from '../../../apis/alert'

const MyPlaylistCard = ({mpl, isOwner, onDelete, onNavigate}) => {

  const handleClick = (e) => {
    if (e.target.tagName.toLowerCase() === 'button') {
      MySwal.fire({
        title: "정말 삭제하시겠습니까?",
        html: '<p class="alert-text">삭제한 플레이리스트는 복구가 불가능합니다.</p>',
        icon: "warning",
        showCancelButton: true,
        confirmButtonText: "삭제",
        cancelButtonText: "취소",
        reverseButtons: false,
        customClass: {
        popup: 'follow-popup',
        icon: 'warning-icon',
        title: 'alert-title',
        text: 'alert-text',
        confirmButton: 'alert-button',
        cancelButton: 'alert-cancle-button'
      }
      }).then((result) => {
        if (result.isConfirmed) {
          onDelete(mpl.id)
        }
      })
      e.stopPropagation();
      return;
    }
    onNavigate(mpl.id);
  }

  return (
    <li className="list-item" key={mpl.id} onClick={handleClick}>
      <input type="hidden" value={mpl.id} name="id" />
      <img
        src={mpl.thumbnailUrl}
        alt="GalaxiNote"
        className="follow-img"
      />
      <div className="info">
        <span className="name-playlist">{mpl.title}</span>
      </div>
      {isOwner && (
        <span className="is-public">
          {mpl.isPublic ? "공개" : "비공개"}
        </span>
      )}
      <div className="right">
        <div className="like-area">
          <span className="like">♥</span>
          <span className="count">{mpl.likeCount}</span>
        </div>
        {isOwner && (
          <button className="btn btn-danger">삭제</button>
        )}
      </div>
    </li>
  )
}

export default MyPlaylistCard