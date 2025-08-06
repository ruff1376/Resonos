import React from 'react'
import Login from './pages/Login'
import {BrowserRouter, Route, Routes} from 'react-router-dom'
import LoginContextProvider from './contexts/LoginContextProvider'

const App = () => {
  return (
    <BrowserRouter>
      <LoginContextProvider>
        <Routes>
          <Route path='/login' element={<Login/>}/>
        </Routes>
      </LoginContextProvider>
    </BrowserRouter>
  )
}

export default App