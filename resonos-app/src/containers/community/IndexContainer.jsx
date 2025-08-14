import React, { useEffect } from 'react'
import Index from '../../components/community/Index'
import Header from '../../components/Header/Header'
import Footer from '../../components/Footer/Footer'

const IndexContainer = () => {

  const getCommunityData = () => {
    // TODO: 인덱스 데이터 요청
  }

  useEffect(() => {
    getCommunityData()
  }, [])
  return (
    <>
    <Header />
    <div className="container">
      <Index />
    </div>
    <Footer />
    </>
  )
}

export default IndexContainer