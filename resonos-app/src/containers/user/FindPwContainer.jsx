import React, { useRef, useState } from 'react'
import FindPwForm from '../../components/user/FindPwForm'
import Header from '../../components/Header/Header'
import Footer from '../../components/Footer/Footer'
import * as ur from '../../apis/user'
import {MySwal} from '../../apis/alert'

const FindPwContainer = () => {


  const [usernameError, setUsernameError] = useState("");
  const checkUsername = useRef(false)


  // 비밀번호 변경, 이메일 송신
  const onChangePwSendMail = async username => {
    let response
    try {
      response = await ur.changePwAndSendMail({username})
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

  // 아이디 존재하는지 체크
  const onCheckUsername = async username => {
    let response
    try {
      response = await ur.isExistsUsername({username})
      if(response.status === 200) {
        checkUsername.current = true
        setUsernameError(response.data)
      }
    } catch(e) {
      if(e.response.status === 400)
        checkUsername.current = false
        setUsernameError(e.response.data)
    }
  }

  return (
    <>
      <Header />
      <div className="container">
        <FindPwForm
          usernameError={usernameError}
          checkUsername={checkUsername}
          onCheckUsername={onCheckUsername}
          onChangePwSendMail={onChangePwSendMail}
        />
      </div>
      <Footer />
    </>
  )
}

export default FindPwContainer