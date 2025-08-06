import './App.css';
import { BrowserRouter, Routes, Route } from 'react-router-dom';
import AdminIndex from './pages/admin/Index';
import Tailwindtest from './tailwind/test';
import './styles/index.css'
import Home from './pages/Home';
import LoginContextProvider from './contexts/LoginContextProvider';
import Login from './pages/Login';
import Main from './pages/list/Main';

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
        </Routes>
      </LoginContextProvider>
    </BrowserRouter>
  )
}

export default App