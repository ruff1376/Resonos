import './App.css';
import { BrowserRouter, Routes, Route } from 'react-router-dom';
import AdminIndex from './pages/admin/Index';
import Tailwindtest from './tailwind/test';
import './styles/index.css'
import Home from './pages/Home';

const App = () => {

  return (
    <BrowserRouter>
      <Routes>
        <Route path='/' element={ <Home/>} />
        <Route path='/admin' element={ <AdminIndex/>} />
        <Route path='/test' element={ <Tailwindtest/>} />
      </Routes>
    </BrowserRouter>
  )
}

export default App