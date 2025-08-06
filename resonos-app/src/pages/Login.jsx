import React, { useState } from 'react'
import LoginForm from '../components/Login/LoginForm';

const Login = () => {

  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [rememberId, setRememberId] = useState(false);
  const [error, setError] = useState(null);

  const handleSubmit = () => {
    alert("안녕")
  }

  return (
    <>
      <LoginForm />
    </>
  )
}

export default Login