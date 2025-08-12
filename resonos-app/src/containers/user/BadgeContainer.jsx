import React, { useEffect, useState } from 'react'
import * as ur from '../../apis/user'
import {MySwal} from '../../apis/alert'
import Badge from '../../components/user/Badge'
import Header from '../../components/Header/Header'
import Footer from '../../components/Footer/Footer'
import { useNavigate } from 'react-router-dom'


const BadgeContainer = () => {

  const [haveBadgeList, setHaveBadgeList] = useState([])
  const [notHaveBadgeList, setNotHaveBadgeList] = useState([])
  const [lastPath, setLastPath] = useState()

  const navigate = useNavigate()

  const getUserBadges = async () => {
    let response

    try {
      response = await ur.getUserBadges()
      if(response.status === 200) {
        const data = response.data
        console.log(data)
        setHaveBadgeList(data.haveBadgeList)
        setNotHaveBadgeList(data.notHaveBadgeList)
        setLastPath(data.lastPath)
      }
    } catch(e) {
      if(e.status === 401) {
        MySwal.fire({
          position: "center",
          icon: "warning",
          title: "로그인이 필요한 서비스입니다.",
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

  useEffect(() => {
    getUserBadges()
  }, [])

  return (
    <div className="container">
      <Header />
      <Badge
        haveBadgeList={haveBadgeList}
        notHaveBadgeList={notHaveBadgeList}
        lastPath={lastPath}
      />
      <Footer />
    </div>
  )
}

export default BadgeContainer