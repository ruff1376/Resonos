import React, { useEffect, useRef, useState } from 'react'
import FollowUser from '../../components/user/FollowUser'
import * as ur from '../../apis/user'
import { MySwal } from '../../apis/alert';
import Header from '../../components/Header/Header';
import Footer from '../../components/Footer/Footer';

const FollowUserContainer = () => {

  const [followCount, setFollowCount] = useState()
  const [followerCount, setFollowerCount] = useState()
  const [lastPath, setLastPath] = useState()
  const [myFollow, setMyFollow] = useState([])
  const [myFollower, setMyFollower] = useState([])
  const isOwner = useRef()
  const userId = useRef()

  // 팔로우 한 아티스트 추가 요청
  const onSearchUsers = async (keyword, offsetRef, limitRef, loadingRef, allLoadedRef, choice) => {

    if (loadingRef.current || allLoadedRef.current) return

    loadingRef.current = true

    try {
      const { data } = await ur.searchUsers({
        userId: userId.current,
        keyword,
        offset: offsetRef.current,
        limit: limitRef.current,
        choice
      })

      switch(choice) {
        case 'follower':
          setMyFollower(prev => {
            const existingIds = new Set(prev.map(t => t.id))
            const filteredData = data.filter(t => !existingIds.has(t.id))
            return [...prev, ...filteredData]
          })
          break

          case 'follow':
          setMyFollow(prev => {
            const existingIds = new Set(prev.map(t => t.id))
            const filteredData = data.filter(t => !existingIds.has(t.id))
            return [...prev, ...filteredData]
          })
          break
      }

      offsetRef.current += limitRef.current

      if (data.length < limitRef.current) {
        allLoadedRef.current = true
      }
    } catch (err) {
      console.error(err)
    } finally {
      loadingRef.current = false
    }
  }

  // 팔로우 요청
  const onFollowUser = async (id, isFollowed) => {
    let response
    try {
      if(isFollowed)
        response = await ur.followUserCancle(id)
      else
        response = await ur.followUser(id)

      if(response.status === 200) {
        MySwal.fire({
          position: "center",
          icon: "success",
          title: response.data,
          showConfirmButton: false,
          timer: 800,
          customClass: {
            popup: 'follow-popup',
            icon: 'success-icon',
            title: 'alert-title'
          }
        })
      }

    } catch(e) {
      console.error('error :', e.response)
    }
  }


  // 팔로우, 팔로워 유저들 데이터 요청
  const getUserFollows = async () => {
    let response
    try {
      response = await ur.getUserFollows()
      console.log(response.data)
      if(response.status === 200) {
        const data = response.data
        userId.current = data.userId
        isOwner.current = data.isOwner
        setLastPath(data.lastPath)
        setFollowCount(data.followCount)
        setFollowerCount(data.followerCount)
        setMyFollow(data.myFollow)
        setMyFollower(data.myFollower)
      }
    } catch(e) {
      console.log('error :', e)
    }
  }

  // 마운트 시 데이터 요청
  useEffect(() => {
    getUserFollows()
  }, [])

  return (
    <div className="container">
      <Header />
      <FollowUser
        followCount={followCount}
        followerCount={followerCount}
        lastPath={lastPath}
        myFollow={myFollow}
        myFollower={myFollower}
        setMyFollow={setMyFollow}
        setMyFollower={setMyFollower}
        isOwner={isOwner}
        userId={userId}
        onSearchUsers={onSearchUsers}
        onFollowUser={onFollowUser}
      />
      <Footer />
    </div>
  )
}

export default FollowUserContainer