import './App.css';
import { BrowserRouter, Routes, Route } from 'react-router-dom';
import AdminIndex from './pages/admin/Index';

const App = () => {

  return (
    <BrowserRouter>
      <Routes>
        <Route path='/admin' element={ <AdminIndex/>} />
      </Routes>
    </BrowserRouter>
  )
}

export default App