import React, { useState, useEffect } from "react";
import axios from "axios";
import TableColumnHeader from "../../components/admin/first/TableColumnHeader";
import Pagination from "../../components/admin/Pagination";
import QuickMenu from "../../components/admin/first/QuickMenu";


/** 행 렌더링 전용 */
const VoteStatsTableContent = ({ stats, columns, idKey, titleKey, showMore, toggleMore }) => {
  const statsSize = stats.length;

  return (
    <>
      {stats.map((stat, idx) => {
        const isFirstOfGroup = idx === 0 || stats[idx - 1][idKey] !== stat[idKey];
        if (!isFirstOfGroup) return null;

        const hasMore = idx + 1 < statsSize && stats[idx + 1][idKey] === stat[idKey];

        // 메인 행
        const mainRow = (
          <div className="list-group-item bg-dark text-light d-flex text-center width-100" key={`main-${idx}`}>
            {columns.map((col, ci) => {
              let value = '';
              switch (ci) {
                case 0: value = stat[idKey]; break;
                case 1: value = stat[titleKey]; break;
                case 2: value = stat.mood_name; break;
                case 3: value = stat.vote_count; break;
                case 4: value = hasMore && (
                  <button
                    type="button"
                    className="btn btn-outline-gold btn-more"
                    onClick={() => toggleMore(idx)}
                  >
                    {showMore[idx] ? "닫기" : "더보기"}
                  </button>
                ); break;
                default: break;
              }
              return (
                <div key={ci} style={col.style}>
                  {value}
                </div>
              );
            })}
          </div>
        );

        // 더보기 행
        const moreRows = showMore[idx]
          ? stats
              .filter((m, mi) => m[idKey] === stat[idKey] && mi !== idx)
              .map((moreStat, moreIdx) => (
                <div
                  key={`more-${moreIdx}`}
                  className="list-group-item bg-dark  d-flex text-center width-100"
                  style={{ background: "#181c23", color: "#ffde7a" }}
                >
                  {columns.map((col, ci) => {
                    let value = '';
                    switch (ci) {
                      case 2: value = moreStat.mood_name; break;
                      case 3: value = moreStat.vote_count; break;
                      default: value = ''; break;
                    }
                    return (
                      <div key={ci} style={col.style}>
                        {value}
                      </div>
                    );
                  })}
                </div>
              ))
          : null;

        return (
          <React.Fragment key={`group-${idx}`}>
            {mainRow}
            {moreRows}
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
    <div className="container max-w-950">
      <h2 className="mb-3 text-light-gold">태그/분위기 투표 현황</h2>

      {/* 탭 */}
      <ul className="nav nav-tabs mb-4">
        {tabs.map((t) => (
          <li className="nav-item" key={t.key}>
            <button
              className={`nav-link ${tab === t.key ? "active" : ""}`}
              onClick={() => {
                setTab(t.key);
                setPage(1);
              }}
            >
              {t.label}
            </button>
          </li>
        ))}
      </ul>

      {loading ? (
        <div>로딩중...</div>
      ) : (
        <div className="admin resonos-card p-4">
          <TableColumnHeader columns={columns} />

          {stats.length > 0 ? (
            <VoteStatsTableContent
              stats={stats}
              columns={columns}               // ✅ columns 전달
              idKey={currentTab.idKey}
              titleKey={currentTab.titleKey}
              toggleMore={toggleMore}
              showMore={showMore}
            />
          ) : (
            <div className="list-group-item text-center text-secondary">
              데이터가 없습니다.
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
    <QuickMenu />
  </main>
);


};

export default VoteStatsContainer;
