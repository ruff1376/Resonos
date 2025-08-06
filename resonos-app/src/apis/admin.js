import axios from 'axios'

axios.defaults.baseURL= "/api"

// admin - index 요청 페이지
export const getAdminIndex = async () => {
    return await axios.get("/admin");
}

// admin - user 관리 페이지
export const getUserList = async (cri) => {
    return await axios.post("/admin/user", cri);
}

export const getUser = async (u_id) => {
    return await axios.get(`/admin/user/${u_id}`);
}

export const updateUser = async (user) => {
    return await axios.put("/admin/user", user);
}

export const deleteUser = async (u_id) => {
    return await axios.delete(`/admin/user/${u_id}`);
}

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