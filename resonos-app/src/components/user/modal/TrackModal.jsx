import React, { useCallback, useEffect, useRef, useState } from 'react'
import {MySwal} from '../../../apis/alert'

// onChange 이벤트 디바운스
function useDebounce(value, delay) {
  const [debouncedValue, setDebouncedValue] = useState(value)
  useEffect(() => {
    const handler = setTimeout(() => {
      setDebouncedValue(value)
    }, delay)
    return () => {
      clearTimeout(handler)
    }
  }, [value, delay])
  return debouncedValue
}

const TrackModal = ({onModal, onAddTrack, onSearchTrack, trackList, setTrackList, setOnModal}) => {

  const [keyword, setKeyword] = useState('')
  const debouncedKeyword = useDebounce(keyword, 300)

  const offsetRef = useRef(0);
  const limitRef = useRef(20);
  const loadingRef = useRef(false);
  const allLoadedRef = useRef(false);

  const [selectedTrackIds, setSelectedTrackIds] = useState([])

  // 스크롤로 트랙 20개씩 추가 요청
  const handleScroll = useCallback(() => {
    if (loadingRef.current || allLoadedRef.current) return
    const container = document.querySelector('.ul-list.modall')
    const nearBottom = container.scrollTop + container.clientHeight >= container.scrollHeight - 150

    if (nearBottom && !loadingRef.current && !allLoadedRef.current) {
      onSearchTrack(debouncedKeyword, offsetRef, limitRef, loadingRef, allLoadedRef)
    }

  }, [onSearchTrack, debouncedKeyword])

  // 키워드 state 변경 함수
  const handleSearchTrack = (e) => {
    setKeyword(e.target.value)
  }

  // 선택한 모달 트랙 목록 토글
  const toggleSelectTrack = (id, title) => {
    setSelectedTrackIds(prev =>
      prev.some(track => track.id === id)
        ? prev.filter(track => track.id !== id)
        : [...prev, { id, title }]
    )
  }

  // 추가하기 버튼 클릭 시 선택된 트랙 ID만 전달
  const handleAddTracks = () => {
    if(selectedTrackIds.length === 0) {
      MySwal.fire({
        position: "center",
        icon: "warning",
        title: "추가할 트랙을 선택해주세요.",
        showConfirmButton: false,
        timer: 1000,
        customClass: {
          popup: 'follow-popup',
          icon: 'success-icon',
          title: 'alert-title'
        }
      })
      return
    }
    MySwal.fire({
      title: `선택한 ${selectedTrackIds.length}개의 트랙을 추가합니다.`,
      showCancelButton: true,
      confirmButtonText: "확인",
      cancelButtonText: "취소",
      reverseButtons: true,
      customClass: {
      popup: 'follow-popup',
      icon: 'warning-icon',
      title: 'alert-title no-icon',
      confirmButton: 'alert-button',
      cancelButton: 'alert-cancle-button'
    }
    }).then((result) => {
      if (result.isConfirmed) onAddTrack(selectedTrackIds.map(track => track.id))
      setSelectedTrackIds([])
    })
  }

  // 스크롤 함수 추가
  useEffect(() => {
    const container = document.querySelector('.ul-list.modall');
    if (!container) return;

    container.addEventListener('scroll', handleScroll);
    return () => {
      const container = document.querySelector('.ul-list.modall');
      if (container) {
        container.removeEventListener('scroll', handleScroll);
      }
    }
  }, [handleScroll])

  // 키워드 바뀌면 offset 0 으로 초기화
  useEffect(() => {

    offsetRef.current = 0
    allLoadedRef.current = false
  }, [debouncedKeyword])

  // 키워드 바뀌면 새로 참조할 수 있게 트랙리스트 초기화
  useEffect(() => {
    if (!debouncedKeyword) return

    offsetRef.current = 0
    allLoadedRef.current = false
    setTrackList([])

    onSearchTrack(debouncedKeyword, offsetRef, limitRef, loadingRef, allLoadedRef)
      .finally(() => {
        loadingRef.current = false
      })
  }, [debouncedKeyword, setTrackList])

  useEffect(() => {
    const handleEsc = (event) => {
      if (event.key === "Escape") {
        setOnModal(false);
      }
    };

    // ESC 키 이벤트 등록
    window.addEventListener("keydown", handleEsc);

    // 컴포넌트 unmount 시 이벤트 제거
    return () => {
      window.removeEventListener("keydown", handleEsc);
    };
  }, [setOnModal]);

  return (
    <>
      <section className={`modal-track ${onModal ? ' action' : ''}`}>
        <button id="close-modal" type="button"
          onClick={() => setOnModal(false)}
        >×
        </button>
        <div className="modal-contents">
          <div className="text-center position-relative">
            <i className="bi bi-search search-icon position-absolute"></i>
            <input
              id="track-search"
              type="text"
              className="modal-input"
              name="keyword"
              placeholder="키워드를 입력하세요."
              onChange={handleSearchTrack}
            />
          </div>
          <div>
            <div className='d-flex align-items-center mb-1'>
              <p className='modal-title-title'>선택한 트랙 목록</p>
              <button
                className='mybtn-gold-sm'
                onClick={() => setSelectedTrackIds([])}
              >
                초기화
              </button>
            </div>
            <ul className='modal-title-list'>
              {
                selectedTrackIds.map((item, index) => (
                  <li>{`${item.title}${index === selectedTrackIds.length-1 ? '' : '  ,'}`}</li>
                ))
              }
            </ul>
          </div>
          <ul className="ul-list modall">
            {trackList.map(track => (
              <li className={`list-item ${selectedTrackIds.some(item => item.id === track.id) ? 'selected' : ''}`}
                  key={track.id}
                  onClick={() => toggleSelectTrack(track.id, track.title)}
              >
                <input type="hidden" value={track.id} />
                <img src={track.coverImage} className="follow-img" alt={track.title} />
                <div className="info">
                  <span className="name-album">{track.title}</span>
                  <span className="name-artist">{track.artistName}</span>
                </div>
                <div className="right">
                  <button className="like like-track">
                    {track.liked ? '♥' : ''}
                  </button>
                </div>
              </li>
            ))}
          </ul>
          <div className="text-center btn-area">
            <button id="btn-modal" type="button" className="btn btn-gold" onClick={handleAddTracks}>
              추가하기
            </button>
          </div>
        </div>
      </section>
    </>
  )
}

export default TrackModal