import React, { useState, useEffect } from 'react';
import TabsGeneric from '../../components/admin/first/TabsGeneric';
import TableColumnHeader from '../../components/admin/first/TableColumnHeader';
import Pagination from '../../components/admin/Pagination';
import SearchForm from '../../components/admin/first/SearchForm';
import MusicAddForm from '../../components/admin/second/MusicAddForm';

import {
  getMusicData,
  deleteTrack, deleteAlbum, deleteArtist,
  searchSpotifyTrack, searchSpotifyAlbum, searchSpotifyArtist,
  syncTrackAjax, syncAlbumAjax, syncArtist,
  searchTrackList, searchAlbumList, searchArtistList,
   saveTrack, saveAlbum, saveArtist  
} from '../../apis/admin';

/**
 * AdminMusicContainer
 * - 탭별(트랙/앨범/아티스트) 관리
 * - DB 검색, Spotify 검색 & 동기화
 * - 등록폼/수정폼 (collapse)
 */
const AdminMusicContainer = () => {
  const [activeTab, setActiveTab] = useState('track');
  const [tracks, setTracks] = useState([]);
  const [albums, setAlbums] = useState([]);
  const [artists, setArtists] = useState([]);
  const [pagination, setPagination] = useState({ page: 1, size: 10, totalPages: 1 });
  const [page, setPage] = useState(1);
  const [keyword, setKeyword] = useState('');
  const [loading, setLoading] = useState(false);
  const [spotifyResults, setSpotifyResults] = useState([]);

  const [showAddForm, setShowAddForm] = useState(false);

  const [editItemId, setEditItemId] = useState(null);
  const [editItemData, setEditItemData] = useState(null);


  // 수기 추가 
  const handleAddSubmit = async (formData) => {
    try {
      if (activeTab === 'track') await saveTrack(formData);
      if (activeTab === 'album') await saveAlbum(formData);
      if (activeTab === 'artist') await saveArtist(formData);
      alert('등록 완료');
      setShowAddForm(false);
      fetchData(activeTab, 1, pagination.size);
    } catch (e) {
      alert('등록 실패: ' + (e.response?.data || e.message));
    }
  };
// 수정 버튼 클릭시 
// 기존: 클릭 시 id만 저장
const handleEditClick = (row) => {
  if (editItemId === row.id) {
    setEditItemId(null);
    setEditItemData(null);
  } else {
    setEditItemId(row.id);
    setEditItemData(row); // ← 선택된 행의 전체 데이터를 저장
  }
};

// 수정된 내용 저장
const handleEditSubmit = async (formData) => {
  try {
    if (activeTab === 'track') await saveTrack(formData);
    if (activeTab === 'album') await saveAlbum(formData);
    if (activeTab === 'artist') await saveArtist(formData);
    alert('수정 완료');
    setEditItemId(null);
    setEditItemData(null);
    fetchData(activeTab, page, pagination.size, keyword);
  } catch (e) {
    alert('수정 실패: ' + (e.response?.data || e.message));
  }
};
  

  /** DB 목록 조회 */
  const fetchData = async (tab = activeTab, pageNum = page, size = 10, kw = keyword) => {
    setLoading(true);
    try {
      const res = await getMusicData(tab, pageNum, size);
      const data = res.data;
      if (tab === 'track') setTracks(data.tracks || []);
      if (tab === 'album') setAlbums(data.albums || []);
      if (tab === 'artist') setArtists(data.artists || []);
      if (data.pagination) {
        setPagination({
          page: data.pagination.page,
          size: data.pagination.size,
          totalPages: Math.ceil(data.pagination.total / data.pagination.size)
        });
      }
    } catch (e) {
      console.error('데이터 조회 실패', e);
    } finally {
      setLoading(false);
    }
  };

  /** 페이지 변경 */
  const onPageChange = (newPage) => {
    setPage(newPage);
    fetchData(activeTab, newPage, pagination.size, keyword);
  };

  /** 탭 변경 */
  const onTabChange = (tab) => {
    setActiveTab(tab);
    setPage(1);
    setKeyword('');
    setSpotifyResults([]);
    setShowAddForm(false);
    fetchData(tab, 1, pagination.size, '');
  };

  /** DB 검색 */
  const handleSearchDB = async (kw) => {
    setKeyword(kw);
    if (!kw) {
      fetchData(activeTab, 1, pagination.size, '');
      return;
    }
    let res;
    if (activeTab === 'track') res = await searchTrackList(kw);
    if (activeTab === 'album') res = await searchAlbumList(kw);
    if (activeTab === 'artist') res = await searchArtistList(kw);
    const data = res.data;
    if (data.success !== false) {
      if (activeTab === 'track') setTracks(data.tracks || []);
      if (activeTab === 'album') setAlbums(data.albums || []);
      if (activeTab === 'artist') setArtists(data.artists || []);
      setPagination(p => ({ ...p, totalPages: 1 }));
    }
  };

  /** Spotify 검색 */
  const handleSearchSpotify = async (kw) => {
    if (!kw) return;
    let res;
    if (activeTab === 'track') res = await searchSpotifyTrack(kw);
    if (activeTab === 'album') res = await searchSpotifyAlbum(kw);
    if (activeTab === 'artist') res = await searchSpotifyArtist(kw);
    const data = res.data;
    if (data.success) {
      setSpotifyResults(data.tracks || data.albums || data.artists || []);
    } else {
      setSpotifyResults([]);
    }
  };

  /** Spotify 동기화 */
  const handleSync = async (id) => {
    try {
      if (activeTab === 'track') await syncTrackAjax(id);
      if (activeTab === 'album') await syncAlbumAjax(id);
      if (activeTab === 'artist') await syncArtist(id);
      alert('동기화 완료');
      fetchData(activeTab, page, pagination.size, keyword);
    } catch (e) {
      alert('동기화 실패');
    }
  };

  /** 삭제 */
  const handleDelete = async (id) => {
    if (!window.confirm('삭제하시겠습니까?')) return;
    try {
      if (activeTab === 'track') await deleteTrack(id);
      if (activeTab === 'album') await deleteAlbum(id);
      if (activeTab === 'artist') await deleteArtist(id);
      fetchData(activeTab, page, pagination.size, keyword);
    } catch (e) {
      alert('삭제 실패');
    }
  };

  useEffect(() => {
    fetchData(activeTab, page, pagination.size, keyword);
  }, []);

  /** 컬럼 정의: html 그대로 flexBasis 반영 */
const columnsMap = {
  track: [
    { label: 'ID', style: { flexBasis: '8%', minWidth: '60px' }, render: row => row.id },
    { label: '제목', style: { flexBasis: '24%', minWidth: '120px' }, render: row => row.title },
    { label: '장르', style: { flexBasis: '10%', minWidth: '70px' }, render: row => row.genre },
    { label: '앨범', style: { flexBasis: '14%', minWidth: '90px' }, render: row => row.albumId },
    { label: '아티스트', style: { flexBasis: '14%', minWidth: '90px' }, render: row => row.artistId },
    { label: '재생', style: { flexBasis: '8%', minWidth: '50px' }, render: row => row.duration },
    { label: '인기', style: { flexBasis: '8%', minWidth: '50px' }, render: row => row.popularity },
    {
      label: '관리', style: { flexBasis: '14%', minWidth: '80px' }, render: (row) => (
    <>
      <button
        className="btn btn-outline-gold btn-sm me-1"
        onClick={() => handleEditClick(row)}
      >
        수정
      </button>
      <button
        className="btn btn-outline-danger btn-sm"
        onClick={() => handleDelete(row.id)}
      >
        삭제
      </button>
    </>
      )
    }
  ],
  album: [
    { label: 'ID', style: { flexBasis: '10%', minWidth: '80px' }, render: row => row.id },
    { label: '제목', style: { flexBasis: '16%', minWidth: '120px' }, render: row => row.title },
    { label: '커버', style: { flexBasis: '8%', minWidth: '60px' }, render: row => row.coverImage && <img src={row.coverImage} alt="" style={{ maxHeight: 32 }} /> },
    { label: '발매일', style: { flexBasis: '13%', minWidth: '90px' }, render: row => row.releaseDate },
    { label: '장르', style: { flexBasis: '10%', minWidth: '70px' }, render: row => row.genre },
    { label: '레이블', style: { flexBasis: '10%', minWidth: '70px' }, render: row => row.label },
    { label: '설명', style: { flexBasis: '13%', minWidth: '90px' }, render: row => row.description },
    { label: '아티스트', style: { flexBasis: '10%', minWidth: '80px' }, render: row => row.artistId },
    {
      label: '관리', style: { flexBasis: '10%', minWidth: '80px' }, render: (row) => (
    <>
      <button
        className="btn btn-outline-gold btn-sm me-1"
        onClick={() => handleEditClick(row)}
      >
        수정
      </button>
      <button
        className="btn btn-outline-danger btn-sm"
        onClick={() => handleDelete(row.id)}
      >
        삭제
      </button>
    </>
      )
    }
  ],
  artist: [
    { label: 'ID', style: { flexBasis: '12%', minWidth: '80px' }, render: row => row.id },
    { label: '이름', style: { flexBasis: '32%', minWidth: '160px' }, render: row => row.name },
    { label: '프로필', style: { flexBasis: '16%', minWidth: '80px' }, render: row => row.profileImage && <img src={row.profileImage} alt="" style={{ maxHeight: 32, borderRadius: '50%' }} /> },
    { label: '장르', style: { flexBasis: '20%', minWidth: '120px' }, render: row => row.genres },
    {
      label: '관리', style: { flexBasis: '20%', minWidth: '120px' }, render: (row) => (
    <>
      <button
        className="btn btn-outline-gold btn-sm me-1"
        onClick={() => handleEditClick(row)}
      >
        수정
      </button>
      <button
        className="btn btn-outline-danger btn-sm"
        onClick={() => handleDelete(row.id)}
      >
        삭제
      </button>
    </>
      )
    }
  ]
};


  const listData = activeTab === 'track' ? tracks : activeTab === 'album' ? albums : artists;
  const columns = columnsMap[activeTab];

return (
  <div>
    <h2 className="mb-4 text-light-gold">음악 데이터 관리</h2>

    <TabsGeneric
      tabs={[
        { key: 'track', label: '트랙' },
        { key: 'album', label: '앨범' },
        { key: 'artist', label: '아티스트' }
      ]}
      activeKey={activeTab}
      onChange={onTabChange}
    />

    <div className="d-flex justify-content-between mb-2">
      <h4>{activeTab} 목록</h4>
      <button className="btn btn-gold btn-sm" onClick={() => setShowAddForm(!showAddForm)}>
        + {activeTab} 추가
      </button>
    </div>

    {showAddForm && (
      <MusicAddForm
        type={activeTab}
        onSubmit={handleAddSubmit}
        onCancel={() => setShowAddForm(false)}
      />
    )}

    {/* Spotify 검색 */}
    <SearchForm
      placeholder={`Spotify ${activeTab} 검색`}
      buttonLabel="검색"
      onSearch={handleSearchSpotify}
    />
    {spotifyResults.length > 0 && (
      <div className="list-group mb-2">
        {spotifyResults.map(item => (
          <div key={item.id} className="list-group-item d-flex align-items-center">
            {(item.image || item.coverImage) && (
              <img
                src={item.image || item.coverImage}
                alt=""
                style={{
                  width: 32,
                  height: 32,
                  objectFit: 'cover',
                  borderRadius: activeTab === 'artist' ? '50%' : '4px',
                  marginRight: 8
                }}
              />
            )}
            <div style={{ flex: 1 }}>
              <b>{item.title || item.name}</b>
              <span className="text-muted small ms-2">{item.id}</span>
              {activeTab === 'artist' && (
                <span className="text-muted small ms-2">{item.genres || ''}</span>
              )}
            </div>
            <button
              className="btn btn-gold btn-sm"
              onClick={() => handleSync(item.id)}
            >
              동기화
            </button>
          </div>
        ))}
      </div>
    )}

    {/* DB 검색 */}
    <SearchForm
      placeholder={`${activeTab}명 검색`}
      buttonLabel="검색"
      onSearch={handleSearchDB}
    />

    {/* 목록 테이블 + 수정폼 */}
    {loading ? (
      <div>로딩중...</div>
    ) : (
      <>
        <TableColumnHeader columns={columns} />
        {listData.map(item => (
          <React.Fragment key={item.id}>
            <div className="list-group-item bg-dark text-light d-flex text-center">
              {columns.map((col, ci) => (
                <div key={ci} style={col.style}>{col.render(item)}</div>
              ))}
            </div>
              {editItemId === item.id && (
                <div className="w-100 p-2 bg-resonos-dark">
                  <MusicAddForm
                    type={activeTab}
                    initialData={editItemData}   // ★ 기존 값 전달
                    onSubmit={handleEditSubmit}
                    onCancel={() => setEditItemId(null)}
                  />
                </div>
              )}

          </React.Fragment>
        ))}
      </>
    )}

    <Pagination
      page={page}
      first={1}
      last={pagination.totalPages || 1}
      prev={page > 1 ? page - 1 : 1}
      next={page < pagination.totalPages ? page + 1 : pagination.totalPages}
      start={Math.max(1, page - 4)}
      end={Math.min(pagination.totalPages, page + 5)}
      pageUri={`/admin/music?tab=${activeTab}&keyword=${encodeURIComponent(keyword)}`}
      onPageChange={onPageChange}
    />
  </div>
);


};

export default AdminMusicContainer;
