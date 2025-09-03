# 🎶 Resonos

> 음악(앨범, 아티스트, 트랙, 플레이리스트) 리뷰 및 커뮤니티 플랫폼  

---

## 🛠 기술 스택
- **Backend**: Spring Boot (MVC, Security)
- **Database**: MyBatis (DB 매퍼)
- **Frontend**: Thymeleaf (뷰 템플릿)
- **Scheduler**: 자동화 배지 지급
- **Auth**: OAuth2 / OIDC 소셜 로그인 (Kakao, Naver, Google)
- **External API**: Spotify, YouTube API

---

## 📌 주요 기능

### 🎵 음악
- 앨범, 아티스트, 트랙 엔티티 관리
- Spotify API 동기화 (아티스트/앨범/트랙 데이터 가져오기)
- 음악 검색, 인기/최신 목록
- 좋아요 / 팔로우 시스템 (앨범, 아티스트, 트랙)
- **차트 시스템**: 사용자 평가 기반 (`ChartElement`, `ChartEntry`)

---

### 📝 리뷰 & 평가
- 앨범/트랙 리뷰 작성 & 평점
- 리뷰 좋아요, 신고, 블라인드 처리
- 차트 평가 항목 점수화 (가사, 사운드, 멜로디 등)
- **배지 시스템 연동** (작성 수/댓글 수 기반 지급)

---

### 👤 회원 / 관리
- 일반 회원가입 & 소셜 로그인 (OAuth2, OIDC)
- 회원 검색 / 활성화 / 비활성화 / 제재(밴)
- 회원 활동 로그 (`UserActivityLog`) 기록
- 프로필 / 이미지 업로드

---

### 🏅 배지 시스템
- 엔티티: `Badge`, `BadgeCondition`, `UserBadge`
- 자동 지급 서비스 (`AutomationScheduler`, 5분 주기)
- 조건 중복 방지 & 조건 기반 지급

---

### 📢 공지 & 알림
- 공지사항 등록 및 노출 기간 관리
  - 사용자별 읽음 처리  
  - 전체 삭제  
  - 페이징 조회  

---

### 🛡 관리자(Admin)
- **대시보드**: 회원 수, 신고 수, 게시물 통계
- 신고 관리 (`Report`) → 상태 (`PENDING / DONE / REJECTED`)
- 음악 관리 (수정/삭제, 외부 동기화)
- 정책 및 환경설정 (`AdminPnSController`)
- 뱃지 / 권한(Role) 관리
- 로그 시스템 (`AdminLog CRUD`)

---

## 🔒 보안
- Spring Security + `CustomUser` (`UserDetails`)
- `LoginSuccessHandler`, OAuth2/OIDC UserService
- WebSocket 인증 기반 실시간 알림

---

## 🚀 향후 확장
- Playlist 기능 확장 (협업 플레이리스트)
- 추천 시스템 (사용자 취향 기반 음악 추천)
- 글로벌 차트 및 지역별 트렌드 분석

---

<details>
  <summary><h3>팀원</h3></summary>
  
  ![Image](https://github.com/user-attachments/assets/472c9b1d-1547-48da-b859-474c7da30082)
  ![Image](https://github.com/user-attachments/assets/2d9ccfbb-8b94-42b1-bf53-2f70743b3712)
</details>

<details>
  <summary><h3>요구사항 정의</h3></summary>
  <a href="https://docs.google.com/spreadsheets/d/197UEqg--TpaKUv3LK0yC1JwajKhI-rdYyBE1SmXbPPc/edit?gid=284806723#gid=284806723" target="">전체보기</a>
  <br>
  
  ![Image](https://github.com/user-attachments/assets/7c49e4ce-648a-4de3-91e2-ca0c89b5abae)
</details>

<details>
  <summary><h3>기능 정의</h3></summary>
  <a href="https://docs.google.com/spreadsheets/d/197UEqg--TpaKUv3LK0yC1JwajKhI-rdYyBE1SmXbPPc/edit?gid=945099833#gid=945099833" taget="_blank">전체보기</a>
  <br>
  
  ![Image](https://github.com/user-attachments/assets/61812d19-a8bf-4eda-8d38-c594871ecb7c)
</details>

<details>
  <summary><h3>테이블 정의</h3></summary>
  
  ![Image](https://github.com/user-attachments/assets/f61cf7dd-5cb5-4c13-877d-af821a97abdf)
  ![Image](https://github.com/user-attachments/assets/d61c8135-15bc-477f-b373-b5d491b02eb7)
</details>






![Image](https://github.com/user-attachments/assets/bd669b2b-1996-4467-b3a7-971e9b7a52ff)
![Image](https://github.com/user-attachments/assets/debc3d7d-cff3-41d2-be44-3083f9f3065d)
![Image](https://github.com/user-attachments/assets/73b99852-8607-432e-968e-11d8e3b2d4c0)
![Image](https://github.com/user-attachments/assets/eaa059af-b884-4823-bcc8-e5ea78c81775)
![Image](https://github.com/user-attachments/assets/d6db5e23-0cf5-493f-8f18-db62633ff622)
![Image](https://github.com/user-attachments/assets/d3f1204d-08c1-440a-84ab-8980edb639e9)
![Image](https://github.com/user-attachments/assets/f6753838-afe2-4250-95c6-5814b66dc9ee)
![Image](https://github.com/user-attachments/assets/62a4397b-c81c-4b67-aa55-6b65ba378a01)
![Image](https://github.com/user-attachments/assets/3099e6ae-f832-480a-b30d-f97a92b62cda)
![Image](https://github.com/user-attachments/assets/9f70da41-0782-4498-b6c3-5a8dfb5b1405)
![Image](https://github.com/user-attachments/assets/07b4ddbb-511d-408f-b868-9d01b736a7cb)
![Image](https://github.com/user-attachments/assets/570a8ef7-f862-4cec-8f70-ea2533460edd)
![Image](https://github.com/user-attachments/assets/cf5b65db-2c7b-43e5-8fd5-a4fee978c828)
![Image](https://github.com/user-attachments/assets/918050b9-8f21-41b1-aefd-b2ca0862e53c)
![Image](https://github.com/user-attachments/assets/2c368398-9205-4968-9b51-8e09e93e20c5)
![Image](https://github.com/user-attachments/assets/4b48a2c1-7b9f-4051-a8d4-a5e34f65e7c5)
![Image](https://github.com/user-attachments/assets/a811649f-9672-4f85-bae8-9e57be375c32)
![Image](https://github.com/user-attachments/assets/30e56cde-440a-4bcb-920d-25946f52a065)
![Image](https://github.com/user-attachments/assets/b2c07274-14cb-4fa3-a331-3da87996227a)
![Image](https://github.com/user-attachments/assets/e17768cd-8d1b-4f8a-a214-1f18de7f2aa4)

![Image](https://github.com/user-attachments/assets/1db7cba2-b2e1-4a8b-8219-71e2be0d2c3b)
![Image](https://github.com/user-attachments/assets/456c31a0-96d5-4bde-89f3-00395cc8d809)
![Image](https://github.com/user-attachments/assets/4642f5e3-44f7-4fc4-9461-50b69f11b4bf)
![Image](https://github.com/user-attachments/assets/b3983335-6cb6-4d8f-af89-510f89e7ee47)
![Image](https://github.com/user-attachments/assets/ac5d15cd-a34c-4b00-9008-75427cc1a562)
![Image](https://github.com/user-attachments/assets/79bad710-510f-4739-96c7-87105e4bf81a)
