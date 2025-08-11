import React, { useEffect, useState } from 'react'
import MypageTab from './MypageTab';
import TrackModal from './modal/TrackModal';
import TrackCard from './card/TrackCard';
import { Link, useNavigate } from 'react-router-dom';

const PlaylistDetailForm = ({playlist, lastPath, isOwner, alreadyLiked, owner, onUpdate, onAddTrack, onSearchTrack, trackList, setTrackList, onModal, setOnModal, onDelete, dragListRef, onLike}) => {

  const [isPublic, setIsPublic] = useState(false);
  const [thumbnail, setThumbnail] = useState(null)

  const navigate = useNavigate()

  // 폼 제출
  const onSubmit = async (e) => {
    e.preventDefault()
    const form = e.target

    // formData 생성
    const formData = new FormData()
    formData.append("title", form.title.value)
    formData.append("description", form.description.value)
    formData.append("isPublic", isPublic)
    formData.append("thumbnailUrl", playlist.thumbnailUrl)

    if (thumbnail) {
      formData.append("thumbnail", thumbnail)
    }

    onUpdate(formData)
  }

  useEffect(() => {
    const thumbnailInput = document.getElementById('thumbnail');

    const handleChange = (event) => {
      const file = event.target.files[0];
      const preview = document.querySelector('.profile-img.edit');

      if (file) {
        const reader = new FileReader();
        reader.onload = (e) => {
          preview.src = e.target.result;
          setThumbnail(file);
        };
        reader.readAsDataURL(file);
      } else {
        preview.src = '';
      }
    };

    if (thumbnailInput) {
      thumbnailInput.addEventListener('change', handleChange);
    }

    return () => {
      if (thumbnailInput) {
        thumbnailInput.removeEventListener('change', handleChange);
      }
    };
  }, [playlist.thumbnailUrl]);


  useEffect(() => {
    setIsPublic(playlist.isPublic)
  }, [playlist.isPublic])

  return (
    <>
      <main className="con con-pli-detail my-5 position-relative">
      {/* 왼쪽 리모컨 */}
      {isOwner && (
        <MypageTab lastPath={lastPath} />
      )}

      {/* 플레이리스트 정보 */}
      <section className={`info-wrapper ${!isOwner ? "go-center" : ""}`}>
        <div className="info-section">
          {/* {success !== undefined && (
            <p className={`success-fail middle ${success === 'false' ? 'error' : ''}`}>
              {success === 'false' ? '업데이트 실패하였습니다.' : '업데이트 완료되었습니다.'}
            </p>
          )} */}
          <div className="title">
            <div>
              <h2 className="text-start">플레이리스트 상세</h2>
            </div>
          </div>

          {!isOwner && owner && (
            <div className="owner-info">
              <Link to={`/users/${owner.id}`}>
                <img src={owner.profileImage} alt="프로필이미지" />
                <p className='name-user'>{owner.nickname}</p>
              </Link>
            </div>
          )}

          <form
            onSubmit={onSubmit}
            className="profile-edit-box"
            encType="multipart/form-data"
          >

            <div className="d-flex align-items-center column-gap-5">
              <div className="d-flex flex-column justify-content-center">
                <label id="profileBtn" htmlFor="thumbnail">
                  <img
                    src={playlist.thumbnailUrl}
                    alt="썸네일 이미지"
                    className="profile-img edit"
                  />
                  {isOwner && (
                    <>
                      <input
                        type="file"
                        name="thumbnail"
                        id="thumbnail"
                      />
                      <input
                        type="hidden"
                        name="thumbnailUrl"
                        defaultValue={playlist.thumbnailUrl}
                      />
                    </>
                  )}
                </label>
                {!isOwner && (
                  <button
                    type="button"
                    id="like-button"
                    className={`like top-margin ${alreadyLiked ? 'already' : ''}`}
                  >
                    {alreadyLiked ? (
                      <i className="bi bi-heart-fill"></i>
                    ) : (
                      <i className="bi bi-heart"></i>
                    )}
                  </button>
                )}
              </div>

              <div className="input-area">
                <label className="profile-edit-label" htmlFor="title">
                  플레이리스트 제목
                </label>
                <input
                  type="text"
                  className="form-control"
                  id="title"
                  defaultValue={playlist.title}
                  readOnly={!isOwner}
                />

                <label className="profile-edit-label" htmlFor="description">
                  플레이리스트 설명
                </label>
                <textarea
                  className="form-control"
                  id="description"
                  rows={2}
                  defaultValue={playlist.description}
                  readOnly={!isOwner}
                />
              </div>
            </div>

            {isOwner && (
              <div className='public-area'>
                <label htmlFor="isPublic">
                  <input
                    id="isPublic"
                    type="radio"
                    name="isPublic"
                    value="true"
                    checked={isPublic === true}
                    onChange={() => setIsPublic(true)}
                  />
                  공개
                </label>
                <label htmlFor="noPublic">
                  <input
                    id='noPublic'
                    type="radio"
                    name="isPublic"
                    value="false"
                    checked={isPublic === false}
                    onChange={() => setIsPublic(false)}
                  />
                  비공개
                </label>
              </div>
            )}

            {/* 트랙 목록 */}
            <div className="info-wrapper">
              <div className="info-section">
                <div className="title">
                  <div>
                    <h2 className="text-start">트랙 목록</h2>
                    <span className="count">
                      {playlist.trackList && playlist.trackList[0].id != null
                        ? playlist.trackList.length
                        : 0}
                    </span>
                  </div>
                  {isOwner && (
                    <button
                      type="button"
                      id="addTrack"
                      onClick={() => setOnModal(!onModal)}
                    >
                      추가하기
                      <img
                        width="20px"
                        height="20px"
                        src="/img/plus_circle.png"
                        alt="추가버튼"
                      />
                    </button>
                  )}
                </div>

                {(!playlist.trackList || playlist.trackList.length === 0) && (
                  <div className="empty-text">추가한 트랙이 없습니다.</div>
                )}

                <ul className="ul-list" ref={dragListRef}>
                  {playlist.trackList &&
                    playlist.trackList.map(
                      (track) =>
                        track.id && (
                          <TrackCard
                            track={track}
                            isOwner={isOwner}
                            key={track.id}
                            onDelete={onDelete}
                            onLike={onLike}
                          />
                        )
                    )}
                </ul>
              </div>
            </div>

            {isOwner && (
              <button type="submit" className="btn btn-gold mt-5">
                수정하기
              </button>
            )}

            <button
              type="button"
              onClick={() => navigate(-1)}
              className={`btn btn-outline-gold ${!isOwner ? 'mt-5' : ''}`}
            >
              뒤로가기
            </button>
          </form>
        </div>
      </section>
      <TrackModal
        onModal={onModal}
        onAddTrack={onAddTrack}
        onSearchTrack={onSearchTrack}
        trackList={trackList}
        setTrackList={setTrackList}
        setOnModal={setOnModal}
      />
    </main>
    </>
  )
}

export default PlaylistDetailForm