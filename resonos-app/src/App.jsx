import './App.css';
import { BrowserRouter, Routes, Route } from 'react-router-dom';
import AdminIndex from './pages/admin/Index';
import Tailwindtest from './tailwind/Test';
import './index.css'; // Tailwind CSS가 포함된 파일을 import
import Home from './pages/Home';
import LoginContextProvider from './contexts/LoginContextProvider';
import Login from './pages/Login';
import Main from './pages/list/Main';
import Mypage from './pages/user/Mypage';
import AdminMembers from './pages/admin/AdminMembersPage';
import AdminMemberDetail from './pages/admin/AdminMemberDetail';
import NewAlbum from './pages/list/NewAlbum';
import Edit from './pages/user/Edit';
import Join from './pages/Join';
import AdminTest from './pages/admin/TestContainer'
import HotPlaylist from './pages/list/HotPlaylist';
import HotAlbum from './pages/list/HotAlbum';
import NewTrack from './pages/list/NewTrack';
import HotTrack from './pages/list/HotTrack';
import NewPlaylist from './pages/list/NewPlaylist';
import Playlist from './pages/user/Playlist';
import Search from './pages/search/Search';
import ArtistSearch from './pages/search/ArtistSearch';
import AlbumSearch from './pages/search/AlbumSearch';
import TrackSearch from './pages/search/TrackSearch';
import PlaylistDetail from './pages/user/PlaylistDetail';
import CreatePlaylist from './pages/user/CreatePlaylist';
import Track from './pages/review/Track';
import Album from './pages/review/Album';
import Artist from './pages/review/Artist';
import AdminReportsContainer from './pages/admin/AdminReportsPage';
import AdminMusicContainer from './containers/admin/AdminMusicContainer';
import UserSearch from './pages/search/UserSearch';
import PlaylistSearch from './pages/search/PlaylistSearch';
import Activity from './pages/user/activity';
import AdminRoleManagePage from './pages/admin/AdminRoleManagePage';
import AdminAnPManagePage from './pages/admin/AdminAnPManagePage';
import AdminPnSManagePage from './pages/admin/AdminPnSManagePage'
import AdminBadgeManagePage from './pages/admin/AdminBadgeManagePage';
import BadgeUsersPage from './pages/admin/BadgeUsersPage';
import AdminTagManagePage from './pages/admin/AdminTagManagePage';
import VoteStatsPage from './pages/admin/VoteStatsPage';
import ReviewReportManagePage from './pages/admin/ReviewReportManagePage';
import AdminNotificationPage from './pages/admin/AdminNotificationPage';
import Notification from './pages/user/Notification';
import LikedMusic from './pages/user/LikedMusic';
import FollowArtist from './pages/user/FollowArtist';
import FollowUser from './pages/user/FollowUser';
import AdminNoticePage from './pages/admin/AdminNoticePage';
import AdminQnAPage from './pages/admin/AdminQnAPage';
import AdminLayout from './layouts/AdminLayout'; // /admin 경로 css 전역으로 적용
import Badge from './pages/user/Badge';
import Security from './pages/user/Security';
import SetNotification from './pages/user/SetNotification';
import FindId from './pages/user/FindId';
import FindPw from './pages/user/FindPw';



// 범위 한정 css 적용 - 테스트 진행중



const App = () => {

  return (
    <BrowserRouter>
      <LoginContextProvider>
        <Routes>
          <Route path='/' element={<Home />} />
          <Route path='/test' element={<Tailwindtest />} />
          <Route path="/list/main" element={<Main />} />

          {/* 컨텐츠 목록 */}
          <Route path="/list/new-albums" element={<NewAlbum />} />
          <Route path="/list/hot-albums" element={<HotAlbum />} />
          <Route path="/list/new-tracks" element={<NewTrack />} />
          <Route path="/list/hot-tracks" element={<HotTrack />} />
          <Route path="/list/new-playlists" element={<NewPlaylist />} />
          <Route path="/list/hot-playlists" element={<HotPlaylist />} />

          {/* 리뷰 */}
          <Route path="/artists" element={<Artist />} />
          <Route path="/albums" element={<Album />} />
          <Route path="/tracks" element={<Track />} />

          {/* 검색 목록 */}
          <Route path="/search" element={<Search />} />
          <Route path="/search/artists" element={<ArtistSearch />} />
          <Route path="/search/albums" element={<AlbumSearch />} />
          <Route path="/search/tracks" element={<TrackSearch />} />
          <Route path="/search/users" element={<UserSearch />} />
          <Route path="/search/playlists" element={<PlaylistSearch />} />

          {/* 공용 */}
          <Route path='/login' element={<Login />} />
          <Route path="/join" element={<Join />} />
          <Route path="/find-id" element={<FindId />} />
          <Route path="/find-pw" element={<FindPw />} />
          {/* 유저 */}
          <Route path="/mypage" element={<Mypage />} />
          <Route path="/users/:id" element={<Mypage />} />
          <Route path="/users/edit" element={<Edit />} />
          <Route path="/users/activities" element={<Activity />} />
          <Route path="/users/notifications" element={<Notification />} />
          <Route path="/users/playlists" element={<Playlist />} />
          <Route path="/users/:id/playlists" element={<Playlist />} />
          <Route path="/playlists/new" element={<CreatePlaylist />} />
          <Route path="/playlists/:id" element={<PlaylistDetail />} />
          <Route path="/users/liked-music" element={<LikedMusic />} />
          <Route path="/users/:id/liked-music" element={<LikedMusic />} />
          <Route path="/users/follow-artists" element={<FollowArtist />} />
          <Route path="/users/:id/follow-artists" element={<FollowArtist />} />
          <Route path="/users/follow-users" element={<FollowUser />} />
          <Route path="/users/:id/follow-users" element={<FollowUser />} />
          <Route path="/users/badges" element={<Badge />} />
          <Route path="/users/security" element={<Security />} />
          <Route path="/users/notifications/status" element={<SetNotification />} />


          {/* 관리자 - 유저 관리 경로 */}
          <Route path="/admin" element={<AdminLayout><AdminIndex /></AdminLayout>} />
          <Route path="/admin/members" element={<AdminLayout><AdminMembers /></AdminLayout>} />
          <Route path="/admin/members/logs" element={<AdminLayout><AdminMemberDetail /></AdminLayout>} />
          <Route path="/admin/test" element={<AdminLayout><AdminTest /></AdminLayout>} />
          <Route path="/admin/report" element={<AdminLayout><AdminReportsContainer /></AdminLayout>} />
          <Route path="/admin/music" element={<AdminLayout><AdminMusicContainer /></AdminLayout>} />
          <Route path="/admin/role" element={<AdminLayout><AdminRoleManagePage /></AdminLayout>} />
          <Route path="/admin/AnP" element={<AdminLayout><AdminAnPManagePage /></AdminLayout>} />
          <Route path="/admin/PolicySetting" element={<AdminLayout><AdminPnSManagePage /></AdminLayout>} />
          <Route path="/admin/Badge" element={<AdminLayout><AdminBadgeManagePage /></AdminLayout>} />
          <Route path="/admin/badge/:badgeId/users" element={<AdminLayout><BadgeUsersPage /></AdminLayout>} />
          <Route path="/admin/tags" element={<AdminLayout><AdminTagManagePage /></AdminLayout>} />
          <Route path="/admin/vote" element={<AdminLayout><VoteStatsPage /></AdminLayout>} />
          <Route path="/admin/report/review" element={<AdminLayout><ReviewReportManagePage /></AdminLayout>} />
          <Route path="/admin/notifications" element={<AdminLayout><AdminNotificationPage /></AdminLayout>} />
          <Route path="/admin/notices" element={<AdminLayout><AdminNoticePage /></AdminLayout>} />
          <Route path="/admin/qna" element={<AdminLayout><AdminQnAPage /></AdminLayout>} />


        </Routes>
      </LoginContextProvider>
    </BrowserRouter>
  )
}

export default App