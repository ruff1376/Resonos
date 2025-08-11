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

          {/* 유저 */}
          <Route path="/join" element={<Join />} />
          <Route path="/mypage" element={<Mypage />} />
          <Route path="/users/:id" element={<Mypage />} />

          {/* 관리자 - 유저 관리 경로 */}
          <Route path="/admin/members" element={<AdminMembers />} />
          <Route path="/admin/members/logs/" element={<AdminMemberDetail />} />
          <Route path="/admin/test/" element={<AdminTest />} />
          
          <Route path="/users/edit" element={<Edit />} />
          <Route path="/users/:id/playlists" element={<Playlist />} />
          <Route path="/users/playlists" element={<Playlist />} />
          <Route path="/playlists/new" element={<CreatePlaylist />} />
          <Route path="/playlists/:id" element={<PlaylistDetail />} />
        </Routes>
      </LoginContextProvider>
    </BrowserRouter>
  )
}

export default App