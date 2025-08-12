import React, { useEffect, useState } from 'react'
import SetNotification from '../../components/user/SetNotification'
import * as ur from '../../apis/user'
import {MySwal} from '../../apis/alert'
import { useNavigate } from 'react-router-dom'
import Header from '../../components/Header/Header'
import Footer from '../../components/Footer/Footer'

const SetNotificationContainer = () => {

  const [notiList, setNotiList] = useState([])
  const [notiType, setNotiType] = useState([])
  const [lastPath, setLastPath] = useState()

  const navigate = useNavigate()

  // 알림 on/off 요청
  const onToggleNoti = async (type) => {
    let response
    try {
      response = await ur.updateNotificationSettings(type)
      if(response.status === 200) {
        console.log(response)
      }
    } catch(e) {
      console.log('error :', e)
    }
  }


  // 알림 데이터 요청
  const getNotificationSettings = async () => {
    let response
    try {
      response = await ur.getNotificationSettings()
      if(response.status === 200) {
        const data = response.data
        setNotiList(data.notiList)
        setNotiType(data.notiType)
        setLastPath(data.lastPath)
      }
    } catch(e) {
      if(e.status === 401) {
        MySwal.fire({
          position: "center",
          icon: "warning",
          title: "권한이 없습니다.",
          showConfirmButton: false,
          timer: 800,
          customClass: {
            popup: 'follow-popup',
            icon: 'success-icon',
            title: 'alert-title'
          }
        })
        setTimeout(() => {
          navigate('/login')
        }, 900)
      }
      console.error('error :', e)
    }
  }

  // 마운트 시 데이터 요청
  useEffect(() => {
    getNotificationSettings()
  }, [])
  return (
    <div className="admin container">
      <Header />
      <SetNotification
        notiList={notiList}
        notiType={notiType}
        lastPath={lastPath}
        onToggleNoti={onToggleNoti}
      />
      <Footer />
    </div>
  )
}

export default SetNotificationContainer