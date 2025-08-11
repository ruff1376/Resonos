import React, { useEffect, useState } from 'react'
import Notification from '../../components/user/Notification'
import * as ur from '../../apis/user'
import {MySwal} from '../../apis/alert'
import Header from '../../components/Header/Header';
import Footer from '../../components/Footer/Footer';

const NotiContainer = () => {

  const [lastPath ,setLastPath] = useState('')
  const [notiList ,setNotiList] = useState([])
  const [count ,setCount] = useState(0)

  const readAll = async () => {
    const ids = notiList
                .filter(noti => noti.isRead == false)
                .map(noti => noti.id)

    try {
      const response = await ur.readAll(ids)
      if(response.status === 200) {
        getNotifications()
      }

    } catch(e) {
      if(e.response.status === 400) {
        MySwal.fire({
          position: "center",
          icon: "warning",
          title:  e.response.data,
          showConfirmButton: false,
          timer: 1000,
          customClass: {
            popup: 'follow-popup',
            icon: 'success-icon',
            title: 'alert-title'
          }
        });
      }
      console.error('error :', e)
    }
  }


  const deleteAll = async () => {

    MySwal.fire({
      title: "정말 삭제하시겠습니까?",
      html: '<p class="alert-text">읽음 처리된 알림 전체가 삭제됩니다.</p>',
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
    }).then( async (result) => {
      if (result.isConfirmed) {
        const ids = notiList
                  .filter(noti => noti.isRead == true)
                  .map(noti => noti.id)
        try {
          const response = await ur.deleteAll(ids)
          if(response.status === 200) {
            getNotifications()
          }

        } catch(e) {
          if(e.response.status === 400) {
            MySwal.fire({
              position: "center",
              icon: "warning",
              title:  e.response.data,
              showConfirmButton: false,
              timer: 1000,
              customClass: {
                popup: 'follow-popup',
                icon: 'success-icon',
                title: 'alert-title'
              }
            });
          }
          console.error('error :', e.response)
        }
      }
    })
  }


  const onToggleRead = async (id, isRead) => {
    if(isRead != false) return

    try {
      const response = await ur.readOne(id)
      console.log(response)
      if(response.status === 200) {
        getNotifications()
      }
    } catch(e) {
      console.error('error :', e)
    }
  }

  // 마운트 시 데이터 요청
  const getNotifications = async () => {
    try {
      const response = await ur.getNotifications()
      const data = response.data

      if(response.status === 200){
        setLastPath(data.lastPath)
        setNotiList(data.notiList)
        setCount(data.count)
      }

    } catch(e) {
      console.error('error :', e)
    }
  }

  // 마운트 시 데이터 요청
  useEffect(() => {
    getNotifications()
  }, [])

  return (
    <div className="container">
      <Header />
      <Notification
        lastPath={lastPath}
        notiList={notiList}
        count={count}
        readAll={readAll}
        deleteAll={deleteAll}
        onToggleRead={onToggleRead}
      />
      <Footer />
    </div>
  )
}

export default NotiContainer