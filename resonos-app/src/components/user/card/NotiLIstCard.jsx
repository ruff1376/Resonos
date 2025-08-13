import React, { useState } from 'react'

const NotiLIstCard = ({noti, onToggleRead}) => {

  const [check, setCheck] = useState(noti.isRead)

  const onCheck = () => {
    setCheck(!check)
  }

  return (
    <li key={noti.id}
      className="list-item"
      data-noti-id={noti.id}
      onClick={() => {
        if (!noti.isRead) {
          onToggleRead && onToggleRead(noti.id, noti.isRead);
          onCheck()
        }
      }}
  >
    <input
      className="is-read"
      id={'is-read' + noti.id}
      type="checkbox"
      checked={noti.isRead}
      onChange={(e) => onToggleRead && onToggleRead(noti.id, e.target.checked)}
    />
    <span className="red-circle">●</span>
    <p>{noti.message}</p>
    <p className="date">
      {new Date(noti.createdAt).toLocaleString('ko-KR', {
        year: 'numeric',
        month: '2-digit',
        day: '2-digit',
        hour: '2-digit',
        minute: '2-digit',
        second: '2-digit',
      })}
    </p>
  </li>
  )
}

export default NotiLIstCard