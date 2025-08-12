import api from './api'

// 회원가입
export const join = async formData => {
  return await api.post('/join', formData)
}

// 아이디 유효성 검사
export const checkId = async (username) => {
  return await api.post('/check-id', { username });
}

// 닉네임 중복 검사
export const checkNickname = async (nickname) => {
    return await api.post('/check-nickname', { nickname })
}

// 이메일 유효성 검사
export const checkEmail = async (email) => {
    return await api.post('/check-email', { email })
}

// 비밀번호 유효성 검사
export const checkPw = async password => {
  return await api.post('/check-password', {password})
}


// 마이페이지 (내 정보)
export const getMyPage = async () => {
  return await api.get("/users/mypage")
}

// 다른 유저 마이페이지
export const getUserPage = async (id) => {
  return await api.get(`/users/${id}`)
}

/* 회원 정보 수정 페이지 */
// 회원 정보 요청
export const getUserEditInfo = async () => {
  return await api.get("/users/edit")
}

// 회원 정보 수정 요청
export const updateUserInfo = async (formData) => {
  return await api.put("/users/edit", formData, {
    headers: { "Content-Type": "multipart/form-data" },
  })
}

/* 내 활동 페이지 */
// 내 활동 페이지 데이터
export const getUserActivity = async () => {
  return await api.get("/users/activity")
}

// 활동 내역 추가 요청 (리뷰)
export const loadMoreUserReviews = async (data) => {
  return await api.post("/users/activity", data)
}

/* 알림 설정 페이지 */
// 알림 설정 페이지
export const getNotificationSettings = async () => {
  return await api.get("/users/notifications/status")
}

// 알림 설정 수정
export const updateNotificationSettings = async (userNoti) => {
  return await api.put("/users/notifications/status", userNoti)
}

/* 팔로우 아티스트 페이지 */
// 팔로우한 아티스트 리스트 (자기 자신 또는 특정 유저)
export const getFollowedArtists = async (id) => {
  return await api.get(id ? `/users/${id}/follow-artist` : `/users/follow-artist`)
}



// 좋아요한 앨범/트랙 페이지
export const getLikedMusic = async (id) => {
  return await api.get(id ? `/users/${id}/liked-music` : `/users/liked-music`)
}

// 배지 페이지
export const getUserBadges = async () => {
  return await api.get("/users/badge")
}

// 유저 정보 요청(보안페이지)
export const getUserInfo = async () => {
  return await api.get('/users/security')
}

// 비밀번호 체크 요청 (보안 페이지)
export const checkPassword = async (password) => {
  const form = new URLSearchParams()
  form.append("password", password)
  return await api.post("/users/check-password", form)
}

// 비밀번호 변경
export const changePassword = async (formData) => {
  return await api.post("/users/change-password", formData, {
    headers: { "Content-Type": "multipart/form-data" },
  })
}

// 회원 탈퇴
export const withdrawUser = async () => {
  return await api.delete("/users")
}

/* 플레이리스트 페이지 */
// 플레이리스트 페이지
export const getUserPlaylists = async (id) => {
  return await api.get(id ? `/users/${id}/playlists` : `/users/playlists`)
}

// 플레이리스트 생성 (multipart/form-data)
export const createPlaylist = async (formData) => {
  return await api.post('/playlists', formData, {
    headers: { 'Content-Type': 'multipart/form-data' }
  })
}

// 플레이리스트 상세 조회
export const getPlaylistDetail = async (id) => {
  return await api.get(`/playlists/${id}`)
}

// 플레이리스트 트랙 순서 변경
export const changeTrackOrder = async (playlistId, orderList) => {
  return await api.put(`/playlists/${playlistId}/tracks/order`, orderList)
}

// 플레이리스트 트랙 추가 (JSON)
export const insertTracks = async (playlistId, trackIdList) => {
  return await api.post(`/playlists/${playlistId}/tracks`, { list: trackIdList }, {
    headers: { 'Content-Type': 'application/json' }
  })
}

// 플레이리스트 트랙 삭제
export const deleteTrackByOrderNo = async (playlistId, orderNo) => {
  return await api.delete(`/playlists/${playlistId}/tracks/${orderNo}`)
}

// 플레이리스트 수정 (multipart/form-data)
export const updatePlaylist = async (id, formData) => {
  return await api.put(`/playlists/${id}`, formData, {
    headers: { 'Content-Type': 'multipart/form-data' }
  })
}

// 플레이리스트 삭제
export const deletePlaylist = async (id) => {
  return await api.delete(`/playlists/${id}`)
}

// 플레이리스트 좋아요
export const likePlaylist = async (playlistId) => {
  return await api.post(`/playlists/${playlistId}/like`)
}

// 플레이리스트 좋아요 취소
export const cancelLikePlaylist = async (playlistId) => {
  return await api.delete(`/playlists/${playlistId}/like`)
}

// 좋아요한 플레이리스트 검색
export const searchMyLikedPlaylist = async ({ userId, keyword, offset, limit }) => {
  return await api.post('/playlists/search', {
    userId,
    keyword,
    offset,
    limit
  })
}

// 플레이리스트 트랙리스트 요청
export const searchTracks = async (data) => {
  return await api.post('/playlists/tracks', data, {
    headers: { 'Content-Type': 'application/json' }
  })
}

// 트랙 좋아요
export const likeTrack = async data => {
  return await api.post('/tracks/like', data, {
    headers: { 'Content-Type': 'application/json' }
  })
}

// 앨범 좋아요
export const likeAlbum = async data => {
  return await api.post('/albums/like', data, {
    headers: { 'Content-Type': 'application/json' }
  })
}

/* 알림 페이지 */
// 알림 리스트 조회
export const getNotifications = async () => {
  return await api.get("/users/notifications")
}
// 알림 단일 읽음 요청
export const readOne = async id => {
  return await api.put('/notifications', {id})
}
// 알림 전체 읽음 요청
export const readAll = async ids => {
  return await api.put('/notifications/all', ids)
}
// 알림 전체 삭제 요청
export const deleteAll = async ids => {
  return await api.delete('/notifications/all', {
    headers: { 'Content-Type': 'application/json' },
    data: ids
  })
}

/* 좋아요 한 앨범/트랙 페이지 */
// 좋아요 한 앨범 추가 요청
export const searchLikedAlbum = async data => {
  return await api.post('/albums/search', data)
}

// 좋아요 한 트랙 추가 요청
export const searchLikedTrack = async data => {
  return await api.post('/tracks/search', data)
}

// 팔로우 한 아티스트 추가 요청
export const searchArtist = async data => {
  return await api.post('/artists/search', data)
}

// 아티스트 팔로우 요청
export const followArtist = async data => {
  return await api.post('/artists/toggle-like', data)
}

// 유저 팔로우 요청
export const followUser = async data => {
  return await api.post('/user-follows', data, {
    headers: { 'Content-Type': 'application/json' },
  })
}

// 유저 팔로우 취소 요청
export const followUserCancle = async data => {
  return await api.delete('/user-follows', {
    headers: { 'Content-Type': 'application/json' },
    data: data
  })
}

/* 유저 팔로워/팔로우 페이지 */
// 유저 팔로우 페이지
export const getUserFollows = async (id) => {
  return await api.get(id ? `/users/${id}/follow-user` : `/users/follow-user`)
}

// 팔로우/팔로워 추가 요청
export const searchUsers = async data => {
  return await api.post('/user-follows/search', data)
}

// 로그아웃
export const logout = async () => {
  return await api.post('/users/logout')
}