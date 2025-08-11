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
import AdminReportsContainer from './pages/admin/AdminReportsPage';
import AdminMusicContainer from './containers/admin/AdminMusicContainer';
import UserSearch from './pages/search/UserSearch';
import PlaylistSearch from './pages/search/PlaylistSearch';
import Activity from './pages/user/activity';
import Notification from './pages/user/Notification';
import LikedMusic from './pages/user/LikedMusic';
import FollowArtist from './pages/user/FollowArtist';

const App = () => {

  return (
    <BrowserRouter>
      <LoginContextProvider>
        <Routes>
          <Route path='/' element={<Home />} />
          <Route path='/admin' element={<AdminIndex />} />
          <Route path='/test' element={<Tailwindtest />} />
          <Route path='/login' element={<Login />} />
          <Route path="/list/main" element={<Main />} />

          {/* 컨텐츠 목록 */}
          <Route path="/list/new-albums" element={<NewAlbum />} />
          <Route path="/list/hot-albums" element={<HotAlbum />} />
          <Route path="/list/new-tracks" element={<NewTrack />} />
          <Route path="/list/hot-tracks" element={<HotTrack />} />
          <Route path="/list/new-playlists" element={<NewPlaylist />} />
          <Route path="/list/hot-playlists" element={<HotPlaylist />} />

          {/* 검색 목록 */}
          <Route path="/search" element={<Search />} />
          <Route path="/search/artists" element={<ArtistSearch />} />
          <Route path="/search/albums" element={<AlbumSearch />} />
          <Route path="/search/tracks" element={<TrackSearch />} />
          <Route path="/search/users" element={<UserSearch />} />
          <Route path="/search/playlists" element={<PlaylistSearch />} />

          {/* 공용 */}
          <Route path="/join" element={<Join />} />
          {/* 유저 */}
          <Route path="/mypage" element={<Mypage />} />
          <Route path="/users/:id" element={<Mypage />} />
          <Route path="/users/activity" element={<Activity />} />
          <Route path="/users/notifications" element={<Notification />} />
          <Route path="/users/liked-music" element={<LikedMusic />} />
          <Route path="/users/:id/liked-music" element={<LikedMusic />} />
          <Route path="/users/follow-artist" element={<FollowArtist />} />
          <Route path="/users/:id/liked-music" element={<FollowArtist />} />
          <Route path="/users/edit" element={<Edit />} />
          <Route path="/users/playlists" element={<Playlist />} />
          <Route path="/users/:id/playlists" element={<Playlist />} />
          <Route path="/playlists/new" element={<CreatePlaylist />} />
          <Route path="/playlists/:id" element={<PlaylistDetail />} />



          {/* 관리자 - 유저 관리 경로 */}
          <Route path="/admin/members" element={<AdminMembers />} />
          <Route path="/admin/members/logs/" element={<AdminMemberDetail />} />
          <Route path="/admin/test/" element={<AdminTest />} />
          <Route path="/admin/report" element={<AdminReportsContainer />} />
          <Route path="/admin/music" element={<AdminMusicContainer />} />

        </Routes>
      </LoginContextProvider>
    </BrowserRouter>
  )
}

export default App