import axios from 'axios';

// axios 객체 생성
const api = axios.create()

// 기본 URL 설정
api.defaults.baseURL = '/api'

export default api;