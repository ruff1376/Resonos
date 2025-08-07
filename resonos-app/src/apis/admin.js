import axios from 'axios';

axios.defaults.baseURL = '/api';

// admin - index 요청 페이지
export const getAdminIndex = async () => {
  return await axios.get('/admin/stats');
};

// admin - 유저(members) 관리 페이지

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





// admin - item 관리 페이지
export const getItemList = async (cri) => {
    return await axios.post("/admin/item", cri);
}

export const getItem = async (i_id) => {
    return await axios.get(`/admin/item/${i_id}`);
}

export const updateItem = async (item) => {
    return await axios.put("/admin/item", item);
}

export const deleteItem = async (i_id) => {
    return await axios.delete(`/admin/item/${i_id}`);
}

// admin - order 관리 페이지
export const getOrderList = async (cri) => {
    return await axios.post("/admin/order", cri);
}

export const getOrder = async (o_id) => {
    return await axios.get(`/admin/order/${o_id}`);
}

export const updateOrder = async (order) => {
    return await axios.put("/admin/order", order);
}

export const deleteOrder = async (o_id) => {
    return await axios.delete(`/admin/order/${o_id}`);
}

// admin - qna 관리 페이지
export const getQnaList = async (cri) => {
    return await axios.post("/admin/qna", cri);
}

export const getQna = async (q_id) => {
    return await axios.get(`/admin/qna/${q_id}`);
}

export const updateQna = async (qna) => {
    return await axios.put("/admin/qna", qna);
}

export const deleteQna = async (q_id) => {
    return await axios.delete(`/admin/qna/${q_id}`);
}