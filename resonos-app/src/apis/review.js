import api from "./api"

// 앨범 초기 페이지
export const getAlbumPage = async (id) => {
  // `get` 요청의 두 번째 인자로 `params`를 전달하여 쿼리 매개변수를 설정합니다.
  return await api.get('/albums', {
    params: {
      id: id
    }
  });
};

// 앨범 좋아요시 좋아요 여부와 좋아요 수 리턴
export const likeAlbum = async (id) => {
  return await api.post(`/albums/like`)
}