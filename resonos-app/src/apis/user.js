import api from './api';

// 마이페이지 (내 정보)
export const getMyPage = async () => {
  return await api.get("/users/mypage");
};

// 다른 유저 마이페이지
export const getUserPage = async (id) => {
  return await api.get(`/users/${id}`);
};

// 회원 정보 편집 페이지 데이터
export const getUserEditInfo = async () => {
  return await api.get("/users/edit");
};

// 회원 정보 수정 요청 (PUT + multipart/form-data)
export const updateUserInfo = async (formData) => {
  return await api.put("/users/edit", formData, {
    headers: { "Content-Type": "multipart/form-data" },
  });
};

// 내 활동 페이지 데이터
export const getUserActivity = async () => {
  return await api.get("/users/activity");
};

// 활동 내역 더 불러오기 (리뷰)
export const loadMoreUserReviews = async (data) => {
  return await api.post("/users/activity", data);
};

// 알림 리스트 조회
export const getNotifications = async () => {
  return await api.get("/users/notifications");
};

// 알림 설정 페이지
export const getNotificationSettings = async () => {
  return await api.get("/users/notifications/status");
};

// 알림 설정 수정
export const updateNotificationSettings = async (userNoti) => {
  return await api.put("/users/notifications/status", userNoti);
};

// 팔로우한 아티스트 리스트 (자기 자신 또는 특정 유저)
export const getFollowedArtists = async (id) => {
  return await api.get(id ? `/users/${id}/follow-artist` : `/users/follow-artist`);
};

// 플레이리스트 페이지
export const getUserPlaylists = async (id) => {
  return await api.get(id ? `/users/${id}/playlists` : `/users/playlists`);
};

// 좋아요한 앨범/트랙 페이지
export const getLikedMusic = async (id) => {
  return await api.get(id ? `/users/${id}/liked-music` : `/users/liked-music`);
};

// 유저 팔로우 페이지
export const getUserFollows = async (id) => {
  return await api.get(id ? `/users/${id}/follow-user` : `/users/follow-user`);
};

// 배지 페이지
export const getUserBadges = async () => {
  return await api.get("/users/badge");
};

// 비밀번호 체크
export const checkPassword = async (password) => {
  const form = new URLSearchParams();
  form.append("password", password);
  return await api.post("/users/check-password", form);
};

// 비밀번호 변경
export const changePassword = async (formData) => {
  return await api.post("/users/change-password", formData, {
    headers: { "Content-Type": "multipart/form-data" },
  });
};

// 회원 탈퇴
export const withdrawUser = async () => {
  return await api.delete("/users");
};
