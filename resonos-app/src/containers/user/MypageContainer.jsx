import React, { useEffect, useState } from 'react'
import UserInfo from '../../components/user/UserInfo'
import UserResource from '../../components/user/UserResource'
import * as ur from '../../apis/user'

const MypageContainer = () => {

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

  const getUserInfo = async () => {
    try {
      const response = await ur.getMyPage()
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

    } catch(e) {
      console.error('error : ', e)
    }
  }

  useEffect(() => {
    getUserInfo()
  }, [])

  return (
    <div className="container">
      <div className="con con-mypage">
        <UserInfo
          currentBadge={currentBadge}
          followCount={followCount}
          followerCount={followerCount}
          user={user}
          isOwner={isOwner}
          countAllReview={countAllReview}
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
    </div>
  )
}

export default MypageContainer