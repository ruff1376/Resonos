import React, { useState } from "react";
import SearchForm from "../first/SearchForm";

const SpotifySearchWithResults = ({ searchFn, type, onSync }) => {
  const [loading, setLoading] = useState(false);
  const [results, setResults] = useState([]);

  const handleSearch = async (kw) => {
    if (!kw.trim()) return;
    setLoading(true);
    try {
      const res = await searchFn(kw);
      const data = res.data || {};

      // Spotify 응답: items 있으면 배열, 없으면 바로 배열
      let items = [];
      if (type === "track") items = data.tracks?.items ?? data.tracks ?? [];
      if (type === "album") items = data.albums?.items ?? data.albums ?? [];
      if (type === "artist") items = data.artists?.items ?? data.artists ?? [];

      setResults(Array.isArray(items) ? items : []);
    } catch (err) {
      console.error(`${type} 검색 오류:`, err);
      setResults([]);
    } finally {
      setLoading(false);
    }
  };

  // 동기화 확인창 추가
  const handleConfirmSync = (id) => {
    if (window.confirm("정말 이 항목을 동기화하시겠습니까?")) {
      onSync && onSync(id);
    }
  };

  return (
    <div className="mb-3 admin">
      <SearchForm
        placeholder={`Spotify ${type} 검색`}
        buttonLabel="검색"
        onSearch={handleSearch}
      />
      {loading && <div>검색중...</div>}

      {!loading && results.length > 0 && (
        // 스크롤 가능한 영역
        <div
          className="list-group mb-2"
          style={{
            maxHeight: "300px",
            overflowY: "auto",
            border: "1px solid var(--main-color)",
            borderRadius: "4px",
          }}
        >
          {results.map((item) => (
            <div
              key={item.id}
              className="list-group-item d-flex align-items-center"
              style={{ backgroundColor: "var(--background-color)", color: "#fff" }}
            >
              {(item.image || item.coverImage || item.images?.[0]?.url) && (
                <img
                  src={item.image || item.coverImage || item.images?.[0]?.url}
                  alt=""
                  style={{
                    width: 32,
                    height: 32,
                    objectFit: "cover",
                    borderRadius: type === "artist" ? "50%" : "4px",
                    marginRight: 8,
                  }}
                />
              )}
              <div style={{ flex: 1 }}>
                <b>{item.title || item.name}</b>
                <span className="text-muted small ms-2">{item.id}</span>
                {type === "artist" && (
                  <span className="text-muted small ms-2">{item.genres || ""}</span>
                )}
              </div>
              {onSync && (
                <button
                  className="btn btn-gold btn-sm"
                  onClick={() => handleConfirmSync(item.id)}
                >
                  동기화
                </button>
              )}
            </div>
          ))}
        </div>
      )}
    </div>
  );
};

export default SpotifySearchWithResults;
