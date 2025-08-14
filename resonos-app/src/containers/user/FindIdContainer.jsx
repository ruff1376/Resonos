import React, { useRef, useState } from 'react'
import FindIdForm from '../../components/user/FindIdForm'
import Header from '../../components/Header/Header'
import Footer from '../../components/Footer/Footer'
import * as ur from '../../apis/user'
import {MySwal} from '../../apis/alert'

const FindIdContainer = () => {

  const [emailError, setEmailError] = useState("")
  const [username, setUsername] = useState("");

  const emailCheck = useRef(false)
  const certiNum = useRef()

  const onSendEmail = async (email) => {
    let response
    const certiNo = Math.floor(100000 + Math.random() * 900000);
    certiNum.current = certiNo
    const data = {
      email,
      certiNo
    }

    try {
      response = await ur.sendMail(data)
      if(response.status === 200) {
        MySwal.fire({
          position: "center",
          icon: "success",
          title: response.data,
          showConfirmButton: false,
          timer: 800,
          customClass: {
            popup: 'follow-popup',
            icon: 'success-icon',
            title: 'alert-title'
          }
        })
      }
    } catch(e) {
      console.error('error :', e)
    }
  }

  // 이메일 존재하는지 체크 후 username 반환
  const onCheckEmail = async email => {
    let response
    try {
      response = await ur.isExistsEmail({email})

      if(response.status === 200) {
        emailCheck.current = true
        setEmailError('확인되었습니다.')
        setUsername(response.data.username)
      }
    } catch(e) {
        emailCheck.current = false
      setEmailError(e.response.data)
    }
  }

  return (
    <>
      <Header />
      <div className="container">
        <FindIdForm
          onCheckEmail={onCheckEmail}
          emailError={emailError}
          emailCheck={emailCheck}
          username={username}
          onSendEmail={onSendEmail}
          certiNum={certiNum}
        />
      </div>
      <Footer />
    </>
  )
}

export default FindIdContainer