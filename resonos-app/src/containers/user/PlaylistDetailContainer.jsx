import React, { useCallback, useEffect, useRef, useState } from 'react'
import * as ur from '../../apis/user'
import { useParams } from 'react-router-dom'
import PlaylistDetailForm from '../../components/user/PlaylistDetailForm'
import 'bootstrap-icons/font/bootstrap-icons.css'
import 'bootstrap/dist/css/bootstrap.min.css'
import {MySwal} from '../../apis/alert'
import Sortable from 'sortablejs';

const PlaylistDetailContainer = () => {

  const [playlist, setPlaylist] = useState([])
  const [lastPath, setLastPath] = useState()
  const [isOwner, setIsOwner] = useState()
  const [alreadyLiked, setAlreadyLiked] = useState()
  const [owner, setOwner] = useState({})
  const [trackList, setTrackList] = useState([])
  const [onModal, setOnModal] = useState(false)
  const [userId, setUserId] = useState()
  const params = useParams()

  const dragListRef = useRef(null)


  // 플레이리스트 트랙 추가 요청
  const onAddTrack = async (idList) => {

    try {
      const response = await ur.insertTracks(playlist.id, idList)
      if(response.status === 200) {
        MySwal.fire({
          position: "center",
          icon: "success",
          title: "플레이리스트에 추가되었습니다.",
          showConfirmButton: false,
          timer: 1000,
          customClass: {
            popup: 'follow-popup',
            icon: 'success-icon',
            title: 'alert-title'
          }
        })
        setTimeout(() => {
          setOnModal(false)
        }, 1100)
      }
    } catch(e) {
      MySwal.fire({
        position: "center",
        icon: "warning",
        title: e.response.data,
        showConfirmButton: false,
        timer: 1000,
        customClass: {
          popup: 'follow-popup',
          icon: 'success-icon',
          title: 'alert-title'
        }
      })
    }
  }

  // 트랙 검색, 요청 함수
  const onSearchTrack = async (keyword, offsetRef, limitRef, loadingRef, allLoadedRef) => {
    console.log(keyword)
    if (loadingRef.current || allLoadedRef.current) return

    loadingRef.current = true

    try {
      const { data } = await ur.searchTracks({
        keyword,
        offset: offsetRef.current,
        limit: limitRef.current
      })

      console.log(data)

      setTrackList(prev => {
        const existingIds = new Set(prev.map(t => t.id))
        const filteredData = data.filter(t => !existingIds.has(t.id))
        return [...prev, ...filteredData]
      })

      offsetRef.current += limitRef.current

      console.log(offsetRef.current)

      if (data.length < limitRef.current) {
        allLoadedRef.current = true
      }
    } catch (err) {
      console.error(err)
    } finally {
      loadingRef.current = false
    }
  }

  // 플레이리스트 상세 정보 요청
  const getPlaylistDetail = async () => {
    try {
      const response = await ur.getPlaylistDetail(params.id)
      const data = response.data
      console.log(data)
      setPlaylist(data.playlist)
      setLastPath(data.lastPath)
      setIsOwner(data.isOwner)
      setAlreadyLiked(data.alreadyLiked)
      setOwner(data.owner)
      setUserId(data.userId)
    } catch(e) {
      console.error('error :', e)
    }
  }

  // 업데이트 요청
  const onUpdate = async (formData) => {
    try {
      const response = await ur.updatePlaylist(playlist.id, formData)
      if(response.status === 200) {
        MySwal.fire({
          position: "center",
          icon: "success",
          title: "플레이리스트가 변경되었습니다.",
          showConfirmButton: false,
          timer: 800,
          customClass: {
            popup: 'follow-popup',
            icon: 'success-icon',
            title: 'alert-title'
          }
        })
      }
    } catch (e) {
      console.error('error :', e)
    }
  }

  // 플레이리스트 트랙 순서 변경 요청
  const onChangeTrackOrder = async orderData => {
    try {
      const response = await ur.changeTrackOrder(playlist.id, orderData)
      console.log(response.data)
    } catch(e) {
      console.error('error :', e)
    }
  }

  // 플레이리스트 트랙 삭제 요청
  const onDelete = async (orderNo) => {
    console.log(playlist.id, orderNo)
    try {
      const response = await ur.deleteTrackByOrderNo(playlist.id, orderNo)
      setPlaylist(prev => ({
        ...prev,
        trackList: response.data.trackList
      }))
    } catch(e) {
      console.error('error :', e)
    }
  }

  // 트랙 좋아요 요청
  const onLike = async (trackId) => {
    try {
      const response = await ur.likeTrack({userId, trackId})
      const data = response.data
      if(response.status === 200) {
        const liked = data.liked
        const text = liked ? '좋아요를 완료했습니다.' : '좋아요를 취소했습니다.'
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
      }
    } catch(e) {
      console.error('error :', e)
    }
  }

  // 트랙 순서 바꾸기
  useEffect(() => {
    if (!isOwner || !dragListRef.current) return

    const sortable = Sortable.create(dragListRef.current, {
      animation: 200,
      scrollContainer: dragListRef.current,
      scroll: true,
      scrollSensitivity: 100,
      scrollSpeed: 20,
      forceFallback: true,
      onEnd: (evt) => {
        const newOrder = [...dragListRef.current.children].map((li, index) => ({
          trackId: li.querySelector('input[type="hidden"]').value,
          orderNo: index + 1
        }))

        onChangeTrackOrder(newOrder)

        Array.from(dragListRef.current.children).forEach((li, index) => {
          const orderElem = li.querySelector('.order-no')
          if(orderElem) orderElem.textContent = index + 1
        })
      },
    })
      return () => {
      sortable.destroy()
    }
  }, [isOwner])

  // 첫 마운트시 데이터 요청
  useEffect(() => {
    getPlaylistDetail()
  }, [])

  return (
    <div className="container">
      <PlaylistDetailForm
        playlist={playlist}
        lastPath={lastPath}
        isOwner={isOwner}
        alreadyLiked={alreadyLiked}
        owner={owner}
        onUpdate={onUpdate}
        onAddTrack={onAddTrack}
        onSearchTrack={onSearchTrack}
        trackList={trackList}
        setTrackList={setTrackList}
        onModal={onModal}
        setOnModal={setOnModal}
        onDelete={onDelete}
        dragListRef={dragListRef}
        onLike={onLike}
      />
    </div>
  )
}

export default PlaylistDetailContainer