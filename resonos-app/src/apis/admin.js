import axios from 'axios';

axios.defaults.baseURL = '/api';

// admin - index 요청 페이지 ######################################################################################################

export const getAdminIndex = async () => {
  return await axios.get('/admin/stats');
};

// admin - 유저(members) 관리 페이지 상단 ##########################################################################################

const membersPath = '/admin/members';

// 목록 (page, size, keyword를 쿼리 파라미터로 전달)
export const list = (page = 1, size = 10, keyword = '') =>
  axios.get(`${membersPath}`, {
    params: { page, size, keyword }
  });

// 조회
export const select = (id) => axios.get(`${membersPath}/${id}`);

// 등록
export const insert = (data, headers) => axios.post(membersPath, data, headers);

// 수정
export const update = (data, headers) => axios.put(membersPath, data, headers);

// 삭제
export const remove = (id) => axios.delete(`${membersPath}/${id}`);

// 활성/비활성 토글 (POST /enable?id=...&enabled=...)
export const toggleEnable = (id, enabled) =>
  axios.post(`${membersPath}/enable`, null, { params: { id, enabled } });

// 밴/해제 (POST /ban?id=...&ban=...&reason=...)
export const banUser = (id, ban = true, reason = '') =>
  axios.post(`${membersPath}/ban`, null, { params: { id, ban, reason } });

// 비밀번호 랜덤 초기화 (POST /reset-password?id=...)
export const resetPassword = (id) =>
  axios.post(`${membersPath}/reset-password`, null, { params: { id } });

// 특정 회원 전체 활동 로그 조회
export const getMemberLogsByUserId = (userId) => 
  axios.get(`${membersPath}/logs`, { params: { userId }});

// admin - 유저(members) 관리 페이지 하단 ##########################################################################################
// admin - 유저(members-log 로그 페이지 상단 ##########################################################################################

const userActivityLogsPath = '/user-activity-logs';

// 전체 목록 조회
export const listUserActivityLogs = (params = {}) =>
  axios.get(userActivityLogsPath, { params });


// 단건 상세 조회 (id로)
export const selectUserActivityLog = (id) => 
  axios.get(`${userActivityLogsPath}/${id}`);

// 등록
export const insertUserActivityLog = (data) => 
  axios.post(userActivityLogsPath, data);

// 수정
export const updateUserActivityLog = (id, data) => 
  axios.put(`${userActivityLogsPath}/${id}`, data);

// 삭제
export const removeUserActivityLog = (id) => 
  axios.delete(`${userActivityLogsPath}/${id}`);

// admin - 유저(members-log 로그 페이지 하단 ##########################################################################################
// admin - 커뮤니티 report 페이지  상단 ##########################################################################################
// import axios from 'axios';

// 리포트 API 기본 경로
const reportBasePath = '/admin/report';

// 리포트 목록 조회 (탭별, 페이징 포함)
export const getReports = (tab = 'all', page = 1, size = 10) =>
  axios.get(reportBasePath, { params: { tab, page, size } });

// 리포트 상세 조회
export const getReportDetail = (id) => axios.get(`${reportBasePath}/${id}`);

// 리포트 삭제
export const deleteReport = (id) => axios.delete(`${reportBasePath}/${id}`);

// 리포트 상태 업데이트 (상태, 처리 메모 포함 가능)
export const updateReportStatus = (id, status, processMemo = '') => {
  const params = { status };
  if (processMemo) params.processMemo = processMemo;
  return axios.put(`${reportBasePath}/${id}/status`, null, { params });
};

// 리뷰 API 기본 경로
const reviewBasePath = '/admin/report/review';

// 리뷰 목록 조회 (타입, 페이징 포함)
export const getReviewList = (type = 'album', page = 1, size = 10) =>
  axios.get(reviewBasePath, { params: { type, page, size } });

// 리뷰 블라인드 처리 (타입, ID, 블라인드 여부)
export const setReviewBlind = (type, id, blinded) =>
  axios.put(`${reviewBasePath}/${type}/${id}/blind`, null, { params: { blinded } });

// 리뷰 삭제 (타입, ID)
export const deleteReview = (type, id) =>
  axios.delete(`${reviewBasePath}/${type}/${id}`);

// admin - 커뮤니티 report 페이지  하단 ##########################################################################################
// admin - 음악데이터관리 페이지  상단 ##########################################################################################

// 기본 경로
const musicBasePath = '/admin/music';

// 목록 조회
export const getMusicData = (tab = 'track', page = 1, size = 10) =>
  axios.get(musicBasePath, { params: { tab, page, size } });

// 트랙
export const saveTrack = (track) =>
  axios.post(`${musicBasePath}/track`, track);
export const deleteTrack = (id) =>
  axios.delete(`${musicBasePath}/track/${id}`);

// 앨범
export const saveAlbum = (album) =>
  axios.post(`${musicBasePath}/album`, album);
export const deleteAlbum = (id) =>
  axios.delete(`${musicBasePath}/album/${id}`);

// 아티스트
export const saveArtist = (artist) =>
  axios.post(`${musicBasePath}/artist`, artist);
export const deleteArtist = (id) =>
  axios.delete(`${musicBasePath}/artist/${id}`);

// Spotify 연동
export const syncTrack = (spotifyTrackId) =>
  axios.post(`${musicBasePath}/track/sync`, null, { params: { spotifyTrackId } });
export const syncArtist = (spotifyArtistId) =>
  axios.post(`${musicBasePath}/sync-artist`, null, { params: { spotifyArtistId } });
export const syncTrackAjax = (spotifyTrackId) =>
  axios.post(`${musicBasePath}/sync-track`, null, { params: { spotifyTrackId } });
export const syncAlbumAjax = (spotifyAlbumId) =>
  axios.post(`${musicBasePath}/sync-album`, null, { params: { spotifyAlbumId } });

// Spotify 검색
export const searchSpotifyArtist = (query) =>
  axios.get(`${musicBasePath}/search-artist`, { params: { query } });
export const searchSpotifyAlbum = (query) =>
  axios.get(`${musicBasePath}/search-album`, { params: { query } });
export const searchSpotifyTrack = (query) =>
  axios.get(`${musicBasePath}/search-track`, { params: { query } });

// DB 검색
export const searchArtistList = (keyword = '') =>
  axios.get(`${musicBasePath}/artist/list`, { params: { keyword } });
export const searchAlbumList = (keyword = '') =>
  axios.get(`${musicBasePath}/album/list`, { params: { keyword } });
export const searchTrackList = (keyword = '') =>
  axios.get(`${musicBasePath}/track/list`, { params: { keyword } });

// 통계/상세
export const getTopTracksByArtist = (id) =>
  axios.get(`${musicBasePath}/artist/${id}/top-tracks`);
export const getTrackCountByArtist = (id) =>
  axios.get(`${musicBasePath}/artist/${id}/track-count`);
export const getTop5TracksInSameAlbum = (id) =>
  axios.get(`${musicBasePath}/track/${id}/same-album-top-tracks`);




// admin - 음악데이터관리 페이지  하단 ##########################################################################################
// admin - 권한 역할 페이지  상단 ##########################################################################################

// 기본 경로
const roleBasePath = '/admin/role';

// 회원 목록
export const getRoleMemberList = (page = 1, size = 10) =>
  axios.get(roleBasePath, { params: { page, size } });

// 권한 목록
export const getUserAuthList = (username) =>
  axios.get(`${roleBasePath}/auth/${encodeURIComponent(username)}`);

// 권한 추가
export const addUserAuth = (username, auth) =>
  axios.post(`${roleBasePath}/auth`, { username, auth });

// 권한 삭제
export const deleteUserAuth = (username, auth) =>
  axios.delete(`${roleBasePath}/auth`, { data: { username, auth } });

// 권한 일괄 수정
export const updateUserAuths = (username, auths) =>
  axios.put(`${roleBasePath}/auth`, { username, auths });

// Admin 권한 토글
export const toggleAdminRole = (username, grant) =>
  axios.post(`${roleBasePath}/auth/toggle`, { username, grant });

// admin - 권한 역할 페이지  하단 ##########################################################################################
// admin - 오픈 api 관리 페이지  상단 ##########################################################################################

const basePath = "/admin/AnP";

// API 키/플러그인 목록
export const getAnPData = () => axios.get(basePath);

// API 키 추가/삭제/토글
export const createApiKey = (data) => axios.post(`${basePath}/api`, data);
export const deleteApiKey = (id) => axios.delete(`${basePath}/api/${id}`);
export const toggleApiKey = (id) => axios.post(`${basePath}/api/toggle/${id}`);

// 플러그인 추가/삭제/토글
export const createPlugin = (data) => axios.post(`${basePath}/plugin`, data);
export const deletePlugin = (id) => axios.delete(`${basePath}/plugin/${id}`);
export const togglePlugin = (id) => axios.post(`${basePath}/plugin/toggle/${id}`);

// TODO : 수정 API 추가(updateApiKey, updatePlugin)
export const updateApiKey = (id, data) => axios.put(`/api/admin/AnP/api/${id}`, data);
export const updatePlugin = (id, data) => axios.put(`/api/admin/AnP/plugin/${id}`, data);




// admin - 오픈 api 관리 페이지  하단 ##########################################################################################
// admin - 정책 및 세팅 관리 페이지  상단 ##########################################################################################


const pnsPath = "/admin/PolicySetting";

// 정책 + 환경설정 전체 조회
export const getPnsData = () => axios.get(pnsPath);

// ------------------------
// 정책 관련 API
// ------------------------
export const createPnsPolicy = (data) =>
  axios.post(`${pnsPath}/policy`, data);

export const updatePnsPolicy = (id, data) =>
  axios.put(`${pnsPath}/policy/${id}`, data);

export const deletePnsPolicy = (id) =>
  axios.delete(`${pnsPath}/policy/${id}`);

// ------------------------
// 환경설정 관련 API
// ------------------------
export const createPnsSetting = (data) =>
  axios.post(`${pnsPath}/setting`, data);

export const updatePnsSettingBatch = (data) =>
  axios.post(`${pnsPath}/setting/update-batch`, data);

export const deletePnsSetting = (id) =>
  axios.delete(`${pnsPath}/setting/${id}`);





// admin - 정책 및 세팅 관리 페이지  하단 ##########################################################################################
// admin - 배지 관리 페이지  상단 ##########################################################################################


const badgePath = "/admin/badge";

// 배지 목록
export const getBadgeData = (msg) =>
  axios.get(badgePath, { params: { msg } });

// 배지 등록 (JSON)
export const insertBadgeCondition = (data) =>
  axios.post(`${badgePath}/insert`, data, {
    headers: { "Content-Type": "application/json" },
  });


// 배지 수정
export const updateBadgeCondition = (data) =>
  axios.put(`${badgePath}/update`, null, { params: data });

// 배지 삭제
export const deleteBadge = (id) =>
  axios.delete(`${badgePath}/delete/badge/${id}`);

// 조건 삭제
export const deleteBadgeCondition = (id) =>
  axios.delete(`${badgePath}/delete/condition/${id}`);

// 지급
export const grantBadge = (userId, badgeId) =>
  axios.post(`${badgePath}/grant`, null, { params: { userId, badgeId } });

// 회수
export const revokeBadge = (userId, badgeId) =>
  axios.post(`${badgePath}/revoke`, null, { params: { userId, badgeId } });

// 일괄 지급
export const grantBadgesAuto = (type) =>
  axios.post(`${badgePath}/grant-auto`, null, { params: { type } });

// 지급자 목록
export const getBadgeUsers = (badgeId) =>
  axios.get(`${badgePath}/badge/${badgeId}/users`);

// 유저 보유 배지
export const getUserBadges = (userId) =>
  axios.get(`${badgePath}/user/${userId}`);

// 지급/회수 로그
export const getBadgeLogs = (userId, badgeId) =>
  axios.get(`${badgePath}/log`, { params: { userId, badgeId } });

// admin - 배지 관리 페이지  하단 ##########################################################################################
// admin - 테그 페이지  상단 ##########################################################################################

const tagPath = "/admin/tags";

// 목록 (페이징)
export const listTags = (page = 1, size = 10, keyword = "") =>
  axios.get(tagPath, { params: { page, size, keyword } });

// 등록
export const addTag = (data) =>
  axios.post(`${tagPath}/add`, data, {
    headers: { "Content-Type": "application/json" },
  });

// 수정
export const updateTag = (id, data) =>
  axios.put(`${tagPath}/${id}`, data, {
    headers: { "Content-Type": "application/json" },
  });

// 삭제
export const deleteTag = (id) => axios.delete(`${tagPath}/${id}`);

// 검색
export const searchTags = (keyword) =>
  axios.get(`${tagPath}/search`, { params: { keyword } });



// admin - 테그 페이지  하단 ##########################################################################################
// admin - 투표 페이지  상단 ##########################################################################################

// 예: 트랙 통계 조회
axios.get("/admin/vote", { params: { tab: "track" } })
  .then(res => {
    if (res.data.success) {
      console.log(res.data.stats);
    }
  });

// 예: 아티스트 통계 조회
axios.get("/admin/vote", { params: { tab: "artist" } });




// admin - 투표 페이지  하단 ##########################################################################################
// admin - 알람 페이지  상단 ##########################################################################################

const notificationPath = "/admin/notifications";

// 알림 목록 조회 (검색, 페이징 포함)
export const getNotifications = (page = 1, size = 10, keyword = "") => {
  return axios.get(notificationPath, {
    params: { page, size, keyword },
  });
};

// 새 알림 등록 (JSON)
export const createNotification = (data) => {
  return axios.post(notificationPath, data, {
    headers: { "Content-Type": "application/json" },
  });
};




// admin - 알람 페이지  하단 ##########################################################################################



