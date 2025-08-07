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
import NewAlbum from './pages/list/NewAlbum';
import Edit from './pages/user/Edit';
import JoinForm from './components/Login/JoinForm';
import Join from './pages/Join';

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

          {/* 유저 */}
          <Route path="/mypage" element={<Mypage />} />
          <Route path="/users/:id" element={<Mypage />} />
          <Route path="/users/edit" element={<Edit />} />
          <Route path="/join" element={<Join />} />
        </Routes>
      </LoginContextProvider>
    </BrowserRouter>
  )
}

export default App