import React, { useEffect, useState } from 'react'
import MypageTab from './MypageTab'
import * as ur from '../../apis/user'
import * as Swal from '../../apis/alert'
import { useNavigate } from 'react-router-dom'

const NewPlaylistForm = () => {

  const [isPublic, setIsPublic] = useState(true)
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
    if (thumbnail) {
      formData.append("thumbnail", thumbnail)
    }

    try {
      const response = await ur.createPlaylist(formData)
      if(response.status === 201) {
        Swal.MySwal.fire({
          position: "center",
          icon: "success",
          title: "플레이리스트가 생성되었습니다.",
          showConfirmButton: false,
          timer: 800,
          customClass: {
            popup: 'follow-popup',
            icon: 'success-icon',
            title: 'alert-title'
          }
        })
        setTimeout(() => {
          navigate('/users/playlists')
        }, 900)
      }
    } catch (e) {
      console.error('error :', e)
    }
  }

  useEffect(() => {
    document.getElementById('thumbnail').addEventListener('change', function (event) {
      const file = event.target.files[0]
      const preview = document.querySelector('.profile-img.edit')

      if (file) {
        const reader = new FileReader()
        reader.onload = function (e) {
          preview.src = e.target.result
          setThumbnail(file)
        }
        reader.readAsDataURL(file)
      } else {
        preview.src = ''
      }
    })
  }, [])


  return (
    <>
      <main className="con con-cre-pli position-relative">
        <MypageTab/>

        <section className="info-wrapper">
          <div className="info-section">
            <form
              className="profile-edit-box"
              onSubmit={onSubmit}
              encType="multipart/form-data"
            >
              <label id="profileBtn" htmlFor="thumbnail">
                <img
                  src="/img/profileImg.png"
                  alt="썸네일 이미지"
                  className="profile-img edit"
                />
                <input
                  type="file"
                  name="thumbnail"
                  id="thumbnail"
                  style={{ display: "none" }}
                />
              </label>

              <div className="input-area">
                <label className="profile-edit-label" htmlFor="title">
                  플레이리스트 제목
                </label>
                <input
                  type="text"
                  id="title"
                  name="title"
                  className="form-control"
                />

                <label className="profile-edit-label" htmlFor="description">
                  플레이리스트 설명
                </label>
                <textarea
                  id="description"
                  name="description"
                  className="form-control"
                  rows={2}
                  placeholder="플레이리스트에 대한 설명을 적어주세요."
                />

                <div>
                  <input
                    type="radio"
                    id="publicTrue"
                    name="isPublic"
                    value="true"
                    checked={isPublic === true}
                    onChange={() => setIsPublic(true)}
                  />
                  <label className="profile-edit-label" htmlFor="publicTrue">
                    공개
                  </label>

                  <input
                    type="radio"
                    id="publicFalse"
                    name="isPublic"
                    value="false"
                    checked={isPublic === false}
                    onChange={() => setIsPublic(false)}
                  />
                  <label className="profile-edit-label" htmlFor="publicFalse">
                    비공개
                  </label>
                </div>
              </div>

              <div className="btn-area">
                <button className="btn btn-gold" type="submit">
                  완료
                </button>
                <button
                  className="btn btn-outline-gold"
                  type="button"
                  onClick={() => {
                    if (onCancel) onCancel()
                    else window.history.back()
                  }}
                >
                  취소
                </button>
              </div>
            </form>
          </div>
        </section>
      </main>
    </>
  )
}

export default NewPlaylistForm