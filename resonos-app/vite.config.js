import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vite.dev/config/
export default defineConfig({
  plugins: [react()],
  server: {
    // 프록시 설정
    proxy: {
      '/api' : {
        target: 'http://localhost:8080',  // (port) 서버 주소
        changeOrigin: true,               // 요청헤더의 Host 도 변경
        secure: false,                    // https 지원 여부
        rewrite: (path) => path.replace(/^\/api/, '')
      }
    }
  }
})
