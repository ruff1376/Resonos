import React, { useEffect, useState } from 'react'
import FollowArtist from '../../components/user/FollowArtist'
import {useParams} from 'react-router-dom'
import * as ur from '../../apis/user'
import { MySwal } from '../../apis/alert';
import Header from '../../components/Header/Header';
import Footer from '../../components/Footer/Footer';

const FollowArtistContainer = () => {

  const [artistList, setArtistList] = useState([])
  const [count, setCount] = useState()
  const [lastPath, setLastPath] = useState()
  const [userId, setUserId] = useState()
  const [isOwner, setIsOwner] = useState()

  const params = useParams()


  // 팔로우 한 아티스트 추가 요청
  const onSearchArtist = async (keyword, offsetRef, limitRef, loadingRef, allLoadedRef) => {
    if (loadingRef.current || allLoadedRef.current) return

    loadingRef.current = true

    try {
      const { data } = await ur.searchArtist({
        userId,
        keyword,
        offset: offsetRef.current,
        limit: limitRef.current
      })

      setArtistList(prev => {
        const existingIds = new Set(prev.map(t => t.id))
        const filteredData = data.filter(t => !existingIds.has(t.id))
        return [...prev, ...filteredData]
      })

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

  // 팔로우/언팔로우 요청
  const onFollow = async artistId => {
    try {
      const response = await ur.followArtist({userId, artistId})
      const data = response.data
      console.log(data)
      if(response.status === 200) {
        const followed = data.followed
        const text = followed ? '팔로우 하였습니다.' : '언팔로우 하였습니다.'
        MySwal.fire({
          position: "center",
          icon: "success",
          title: text,
          showConfirmButton: false,
          timer: 800,
          customClass: {
            popup: 'follow-popup',
            icon: 'success-icon',
            title: 'alert-title'
          }
        })
        setCount(prev => followed ? prev + 1 : prev - 1)
      }
    } catch(e) {
      console.error('error :', e)
    }
  }

  // 팔로우 아티스트 데이터 요청
  const getFollowedArtists = async () => {
    let response
    try {
      if(params.id)
        response = await ur.getFollowedArtists(params.id)
      else
        response = await ur.getFollowedArtists()

      if(response.status === 200) {
        const data = response.data
        setArtistList(data.artistList)
        setCount(data.count)
        setLastPath(data.lastPath)
        setUserId(data.userId)
        setIsOwner(data.isOwner)
      }

    } catch(e) {
      console.error('error :', e)
    }
  }

  // 마운트 시 데이터 요청
  useEffect(() => {
    getFollowedArtists()
  }, [])

  return (
    <div className="container">
      <Header />
      <FollowArtist
        artistList={artistList}
        setArtistList={setArtistList}
        count={count}
        lastPath={lastPath}
        userId={userId}
        isOwner={isOwner}
        onSearchArtist={onSearchArtist}
        onFollow={onFollow}
      />
      <Footer />
    </div>
  )
}

export default FollowArtistContainer