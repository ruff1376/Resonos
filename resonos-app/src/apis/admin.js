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