import React from 'react'

const NotificationCard = ({noti, notiType, onToggleNoti}) => {

  const handleToggleNoti = () => {
    onToggleNoti({
      type: noti.type
    })
  }

  return (
    <li
      className="list-item justify-content-between"
    >
      <span className="type">{notiType[noti.type]}</span>
      <input
        type="hidden"
        className="type-name"
        value={noti.type}
      />
      <label className="toggle-switch">
        <input
          type="checkbox"
          name="notification"
          defaultChecked={noti.isEnabled}
          onChange={handleToggleNoti}
        />
        <span className="slider"></span>
      </label>
    </li>
  )
}

export default NotificationCard