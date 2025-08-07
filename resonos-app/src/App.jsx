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



          {/* 유저 */}
          <Route path="/mypage" element={<Mypage />} />
          <Route path="/users/:id" element={<Mypage />} />

          {/* 관리자 - 유저 관리 경로 */}
          <Route path="/admin/members" element={<AdminMembers />} />
          <Route path="/admin/members/:id" element={<AdminMemberDetail />} />
          
        </Routes>
      </LoginContextProvider>
    </BrowserRouter>
  )
}

export default App