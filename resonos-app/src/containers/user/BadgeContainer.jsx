import React, { useEffect, useState } from 'react'
import * as ur from '../../apis/user'
import Badge from '../../components/user/Badge'
import Header from '../../components/Header/Header'
import Footer from '../../components/Footer/Footer'
const BadgeContainer = () => {

  const [haveBadgeList, setHaveBadgeList] = useState([])
  const [notHaveBadgeList, setNotHaveBadgeList] = useState([])
  const [lastPath, setLastPath] = useState()

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