import React, { useEffect, useState } from 'react'
import LoginForm from '../components/Login/LoginForm';
import Footer from '../components/Footer/Footer'
import Header from '../components/Header/Header'

const Login = () => {

  return (
    <div className="container">
      <Header />
      <LoginForm />
      <Footer />
    </div>
  )
}

export default Login