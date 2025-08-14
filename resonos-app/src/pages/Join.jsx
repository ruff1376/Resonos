import React from 'react'
import JoinForm from '../components/Login/JoinForm'
import Footer from '../components/Footer/Footer'
import Header from '../components/Header/Header'

const Join = () => {
  return (
    <>
      <Header />
      <div className="container">
        <JoinForm />
      </div>
      <Footer />
    </>
  )
}

export default Join