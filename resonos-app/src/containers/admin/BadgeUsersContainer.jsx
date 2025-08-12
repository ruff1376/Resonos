import React, { useEffect, useState } from "react";
import { getBadgeUsers } from "../../apis/admin"; 
import { useParams, Link } from "react-router-dom";
import TableColumnHeader from "../../components/admin/first/TableColumnHeader";
import styles from "../../components/admin/css/admin.module.css";


const BadgeUsersContainer = () => {
  const { badgeId } = useParams();
  const [users, setUsers] = useState([]);
  const [logs, setLogs] = useState([]);
  const [loading, setLoading] = useState(false);

  const fetchData = async () => {
    setLoading(true);
    try {
      const res = await getBadgeUsers(badgeId);
      setUsers(res.data.users || []);
      setLogs(res.data.logs || []);
    } catch (err) {
      console.error("배지 지급자 목록 조회 실패", err);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchData();
  }, [badgeId]);

  // 지급자 목록 컬럼
  const userColumns = [
    { label: "#", style: { flexBasis: "5%", minWidth: "30px" } },
    { label: "유저ID", style: { flexBasis: "15%", minWidth: "60px" } },
    { label: "유저명", style: { flexBasis: "30%", minWidth: "100px" } },
    { label: "지급일시", style: { flexBasis: "30%", minWidth: "140px" } },
    { label: "액션", style: { flexBasis: "20%", minWidth: "100px" } },
  ];

  // 로그 컬럼
  const logColumns = [
    { label: "#", style: { flexBasis: "5%", minWidth: "30px" } },
    { label: "유저ID", style: { flexBasis: "15%", minWidth: "60px" } },
    { label: "액션", style: { flexBasis: "15%", minWidth: "60px" } },
    { label: "담당자", style: { flexBasis: "15%", minWidth: "60px" } },
    { label: "사유", style: { flexBasis: "30%", minWidth: "100px" } },
    { label: "일시", style: { flexBasis: "20%", minWidth: "140px" } },
  ];

  return (
    <div className="container py-4">
      <h2 className="mb-4">
        배지 지급자 목록{" "}
        <span style={{ color: "#4fc3f7" }}>(Badge ID: {badgeId})</span>
      </h2>
      <div className="mb-3">
        <Link to="/admin/badge" className="btn btn-outline-primary btn-sm">
          &laquo; 배지 관리로
        </Link>
      </div>

      {/* 지급자(보유자) */}
      <div className={`${styles["resonos-card"]} mb-4`}>
        <div className="fw-semibold bg-resonos-dark text-light p-2">
          지급/보유자 현황
        </div>
        {loading ? (
          <div className="p-3">로딩중...</div>
        ) : users.length > 0 ? (
          <>
            <TableColumnHeader columns={userColumns} />
            {users.map((u, idx) => (
              <div
                key={u.userId}
                className="d-flex border-bottom text-center align-items-center"
              >
                <div style={userColumns[0].style}>{idx + 1}</div>
                <div style={userColumns[1].style}>{u.userId}</div>
                <div style={userColumns[2].style}>{u.userName}</div>
                <div style={userColumns[3].style}>
                  {u.grantedAt
                    ? new Date(u.grantedAt).toLocaleString()
                    : "-"}
                </div>
                <div style={userColumns[4].style}>
                  <Link
                    to={`/admin/badge/user/${u.userId}`}
                    className="btn btn-info btn-xs"
                  >
                    유저 배지 이력
                  </Link>
                </div>
              </div>
            ))}
          </>
        ) : (
          <div className="text-secondary text-center py-3">
            아직 해당 배지를 보유한 사용자가 없습니다.
          </div>
        )}
      </div>

      {/* 지급/회수 이력 */}
      <div className={`${styles["resonos-card"]} mb-4`}>
        <div className="fw-semibold bg-resonos-dark text-light p-2">
          이 배지의 지급/회수 이력
        </div>
        {loading ? (
          <div className="p-3">로딩중...</div>
        ) : logs.length > 0 ? (
          <>
            <TableColumnHeader columns={logColumns} />
            {logs.map((log, idx) => (
              <div
                key={idx}
                className="d-flex border-bottom text-center align-items-center"
              >
                <div style={logColumns[0].style}>{idx + 1}</div>
                <div style={logColumns[1].style}>{log.userId}</div>
                <div style={logColumns[2].style}>
                  {log.action === "GRANT" ? (
                    <span className="badge bg-success">지급</span>
                  ) : log.action === "REVOKE" ? (
                    <span className="badge bg-danger">회수</span>
                  ) : (
                    <span className="badge bg-secondary">기타</span>
                  )}
                </div>
                <div style={logColumns[3].style}>
                  {log.actorId || "-자동-"}
                </div>
                <div style={logColumns[4].style}>{log.reason || "-"}</div>
                <div style={logColumns[5].style}>
                  {log.createdAt
                    ? new Date(log.createdAt).toLocaleString()
                    : "-"}
                </div>
              </div>
            ))}
          </>
        ) : (
          <div className="text-secondary text-center py-3">
            이 배지 지급/회수 이력이 없습니다.
          </div>
        )}
      </div>
    </div>
  );
};

export default BadgeUsersContainer;
