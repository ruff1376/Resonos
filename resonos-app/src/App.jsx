import './App.css';
import { BrowserRouter, Routes, Route } from 'react-router-dom';
import AdminIndex from './pages/admin/Index';
import Tailwindtest from './tailwind/Test';
import './index.css'; // Tailwind CSS가 포함된 파일을 import

const App = () => {

  return (
    <BrowserRouter>
      <Routes>
        <Route path='/admin' element={ <AdminIndex/>} />
        <Route path='/test' element={ <Tailwindtest/>} />
      </Routes>
    </BrowserRouter>
  )
}

export default App