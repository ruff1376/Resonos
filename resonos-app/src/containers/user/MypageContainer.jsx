import React, { useEffect, useState } from 'react'
import UserInfo from '../../components/user/UserInfo'
import UserResource from '../../components/user/UserResource'
import * as ur from '../../apis/user'
import Header from '../../components/Header/Header'
import Footer from '../../components/Footer/Footer'
import {MySwal} from '../../apis/alert'
import { useLocation, useNavigate, useParams } from 'react-router-dom'

const MypageContainer = () => {

  const location = useLocation()
  const params = useParams()
  const navigate = useNavigate()

  const [albumList, setAlbumList] = useState([]);
  const [artistList, setArtistList] = useState([]);
  // const [badgeCount, setBadgeCount] = useState();
  const [badgeList, setBadgeList] = useState([]);
  const [chartData, setChartData] = useState({});
  const [countAllReview, setCountAllReview] = useState();
  const [currentBadge, setCurrentBadge] = useState();
  const [followCount, setFollowCount] = useState();
  const [followerCount, setFollowerCount] = useState();
  const [isOwner, setIsOwner] = useState(false);
  const [playlists, setPlaylists] = useState([]);
  const [trackList, setTrackList] = useState([]);
  const [user, setUser] = useState({});
  const [utl, setUtl] = useState({});
  const [alreadyFollow, setAlreadyFollow] = useState()



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

        setFollowerCount(prev => !isFollowed ? prev + 1 : prev - 1)
        setAlreadyFollow(!alreadyFollow)
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
      console.error('error :', e.response)
    }
  }

  const getUserInfo = async () => {

    let response

    try {
      if(location.pathname === '/mypage')
        response = await ur.getMyPage()
      else
        response = await ur.getUserPage(params.id)

      const data = response.data
      console.log(data)
      setAlbumList(data.albumList || []);
      setArtistList(data.artistList || []);
      // setBadgeCount(data.badgeCount);
      setBadgeList(data.badgeList || []);
      setChartData(data.chartData || {});
      setCountAllReview(data.countAllReview);
      setCurrentBadge(data.currentBadge || "");
      setFollowCount(data.followCount);
      setFollowerCount(data.followerCount);
      setIsOwner(data.isOwner);
      setPlaylists(data.playlists || []);
      setTrackList(data.trackList || []);
      setUser(data.user || {});
      setUtl(data.utl || {});
      setAlreadyFollow(data.alreadyFollow)

    } catch(e) {
      console.log(e.response)
      if(e.status == 401 && location.pathname === '/mypage') {
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
      console.error('error : ', e)
    }
  }

  useEffect(() => {
    getUserInfo()
  }, [])

  return (
    <div className="container">
      <Header />
      <div className="con con-mypage">
        <UserInfo
          currentBadge={currentBadge}
          followCount={followCount}
          followerCount={followerCount}
          user={user}
          isOwner={isOwner}
          countAllReview={countAllReview}
          alreadyFollow={alreadyFollow}
          onFollowUser={onFollowUser}
        />
        <UserResource
          albumList={albumList}
          artistList={artistList}
          badgeList={badgeList}
          playlists={playlists}
          trackList={trackList}
          utl={utl}
          isOwner={isOwner}
          user={user}
          countAllReview={countAllReview}
          chartData={chartData}
        />
      </div>
      {/* <Footer /> */}
    </div>
  )
}

export default MypageContainer