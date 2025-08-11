import React, { useState, useEffect } from "react";
import axios from "axios";
import TableColumnHeader from "../../components/admin/first/TableColumnHeader";
import Pagination from "../../components/admin/Pagination";
import styles from "../../components/admin/css/admin.module.css";

/** 행 렌더링 전용 */
const VoteStatsTableContent = ({ stats, idKey, titleKey, showMore, toggleMore }) => {
  const statsSize = stats.length;

  return (
    <>
      {stats.map((stat, idx) => {
        const isFirstOfGroup = idx === 0 || stats[idx - 1][idKey] !== stat[idKey];
        if (!isFirstOfGroup) return null;

        const hasMore = idx + 1 < statsSize && stats[idx + 1][idKey] === stat[idKey];

        return (
          <React.Fragment key={`row-${idx}`}>
            <div
              className={`vote-table-row track-group-start ${idx === 0 ? "first-track" : ""}`}
              style={{ fontWeight: 600 }}
            >
              <div className="vote-col-id">{stat[idKey]}</div>
              <div className="vote-col-title">{stat[titleKey]}</div>
              <div className="vote-col-mood">{stat.mood_name}</div>
              <div className="vote-col-count">{stat.vote_count}</div>
              <div className="vote-col-more">
                {hasMore && (
                  <button
                    type="button"
                    className="btn btn-outline-gold btn-more"
                    onClick={() => toggleMore(idx)}
                    style={{ fontSize: "1.1em", padding: "2px 16px" }}
                  >
                    {showMore[idx] ? "닫기" : "더보기"}
                  </button>
                )}
              </div>
            </div>

            {/* 더보기 영역 */}
            <div className={`more-moods ${showMore[idx] ? "show" : ""}`}>
              {stats.map((moreStat, moreIdx) => {
                if (moreStat[idKey] !== stat[idKey] || moreIdx === idx) return null;
                return (
                  <div
                    key={`more-${moreIdx}`}
                    className="vote-table-row"
                    style={{ background: "#181c23", color: "#ffde7a" }}
                  >
                    <div className="vote-col-id"></div>
                    <div className="vote-col-title"></div>
                    <div className="vote-col-mood">{moreStat.mood_name}</div>
                    <div className="vote-col-count">{moreStat.vote_count}</div>
                    <div className="vote-col-more"></div>
                  </div>
                );
              })}
            </div>
          </React.Fragment>
        );
      })}
    </>
  );
};

/** 메인 컨테이너 */
const VoteStatsContainer = () => {
  const [tab, setTab] = useState("track");
  const [stats, setStats] = useState([]);
  const [loading, setLoading] = useState(false);
  const [showMore, setShowMore] = useState({});

  const [page, setPage] = useState(1);
  const [pagination, setPagination] = useState({ totalPages: 1, total: 0, size: 10 });

  const toggleMore = (idx) => {
    setShowMore((prev) => ({ ...prev, [idx]: !prev[idx] }));
  };

const fetchStats = async (selectedTab, pageNum = 1) => {
  setLoading(true);
  try {
    const res = await axios.get("/admin/vote", { params: { tab: selectedTab, page: pageNum } });
    setStats(res.data.stats || []);
    // 🔹 setTab 제거 (탭 변경은 onClick에서만)
    setShowMore({});
    const total = res.data.total || 0;
    const size = res.data.size || 10;
    const totalPages = total && size ? Math.ceil(total / size) : 1;
    setPagination({ totalPages, total, size });
  } catch (e) {
    console.error("투표 현황 조회 실패", e);
    setStats([]);
  } finally {
    setLoading(false);
  }
};


  useEffect(() => {
    fetchStats(tab, page);
  }, [tab, page]);

  const tabs = [
    { key: "track", label: "트랙 투표", idKey: "track_id", titleKey: "track_title" },
    { key: "album", label: "앨범 투표", idKey: "album_id", titleKey: "album_title" },
    { key: "artist", label: "아티스트 투표", idKey: "artist_id", titleKey: "artist_name" },
  ];

  const currentTab = tabs.find((t) => t.key === tab);
  const columns = [
    { label: currentTab.idKey.toUpperCase(), style: { flexBasis: "22%", minWidth: "120px" } },
    { label: currentTab.titleKey.replace("_", " "), style: { flexBasis: "28%", minWidth: "100px" } },
    { label: "태그/분위기", style: { flexBasis: "30%", minWidth: "90px" } },
    { label: "투표수", style: { flexBasis: "10%", minWidth: "60px" } },
    { label: "", style: { flexBasis: "10%", minWidth: "60px" } },
  ];

  return (
    <main className="py-5 bg-resonos-dark">
      <div className="container" style={{ maxWidth: 950 }}>
        <h2 className="mb-3 text-light-gold">태그/분위기 투표 현황</h2>

        {/* 탭 제네릭 */}
        <ul className="nav nav-tabs mb-4">
          {tabs.map((t) => (
            <li className="nav-item" key={t.key}>
              <button
                className={`nav-link ${tab === t.key ? "active" : ""}`}
                onClick={() => { setTab(t.key); setPage(1); }}
              >
                {t.label}
              </button>
            </li>
          ))}
        </ul>

        {loading ? (
          <div>로딩중...</div>
        ) : (
          <div className={`${styles["resonos-card"]} p-4`} style={{ padding: "2.5rem" }}>
            <TableColumnHeader columns={columns} />
            <VoteStatsTableContent
              stats={stats}
              idKey={currentTab.idKey}
              titleKey={currentTab.titleKey}
              toggleMore={toggleMore}
              showMore={showMore}
            />
            {stats.length === 0 && (
              <div className="vote-table-row text-center text-secondary">
                <div className="vote-col-id" style={{ flex: 1 }}>
                  투표 현황 데이터가 없습니다.
                </div>
              </div>
            )}

            {pagination.totalPages > 1 && (
              <Pagination
                page={page}
                first={1}
                last={pagination.totalPages}
                prev={page > 1 ? page - 1 : 1}
                next={page < pagination.totalPages ? page + 1 : pagination.totalPages}
                start={Math.max(1, page - 4)}
                end={Math.min(pagination.totalPages, page + 5)}
                pageUri={`/admin/vote?tab=${tab}`}
                onPageChange={(newPage) => setPage(newPage)}
              />
            )}
          </div>
        )}
      </div>
    </main>
  );
};

export default VoteStatsContainer;
