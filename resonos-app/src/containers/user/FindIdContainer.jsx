import React, { useState } from 'react'
import FindIdForm from '../../components/user/FindIdForm'
import Header from '../../components/Header/Header'
import Footer from '../../components/Footer/Footer'
import * as ur from '../../apis/user'

const FindIdContainer = () => {

  const [emailError, setEmailError] = useState("")
  const [emailCheck, setEmailCheck] = useState(false)

  const onCheckEmail = async email => {
    let response
    try {
      response = await ur.isExistsEmail({email})

      if(response.status === 200) {
        setEmailError('확인되었습니다.')
        console.log(response.data)
      }
    } catch(e) {
      setEmailError(e.response.data)
    }
  }

  return (
    <div className="container">
      <Header />
      <FindIdForm
        onCheckEmail={onCheckEmail}
        emailError={emailError}
      />
      <Footer />
    </div>
  )
}

export default FindIdContainer