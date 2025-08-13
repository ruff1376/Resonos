import React, { useEffect, useState } from "react";
import {
  getBadgeData,
  insertBadgeCondition,
  updateBadgeCondition,
  deleteBadge,
  grantBadgesAuto,
} from "../../apis/admin"; 
import FormInput from "../../components/admin/first/FormInput";
import FormSelect from "../../components/admin/first/FormSelect";
import TableColumnHeader from "../../components/admin/first/TableColumnHeader";
import { Link } from "react-router-dom";
import QuickMenu from "../../components/admin/first/QuickMenu";


const AdminBadgeManageContainer = () => {
  const [badges, setBadges] = useState([]);
  const [badgeConditionsMap, setBadgeConditionsMap] = useState({});
  const [badgeUserCount, setBadgeUserCount] = useState({});
  const [loading, setLoading] = useState(false);

  const [newBadge, setNewBadge] = useState({
    name: "",
    description: "",
    iconUrl: "",
    conditionType: "",
    conditionValue: "",
  });

  const [editBadgeId, setEditBadgeId] = useState(null);
  const [editForm, setEditForm] = useState({});

  const fetchData = async () => {
    setLoading(true);
    try {
      const res = await getBadgeData();
      const data = res.data;
      setBadges(data.badges || []);
      setBadgeConditionsMap(data.badgeConditionsMap || {});
      setBadgeUserCount(data.badgeUserCount || {});
    } catch (e) {
      console.error("배지 목록 조회 실패", e);
    } finally {
      setLoading(false);
    }
  };
  useEffect(() => {
    fetchData();
  }, []);

  const handleCreate = async (e) => {
    e.preventDefault();
    if (!newBadge.name || !newBadge.description || !newBadge.conditionType || !newBadge.conditionValue) {
      alert("모든 필수 항목을 입력하세요.");
      return;
    }
    try {
      await insertBadgeCondition(newBadge);
      alert("등록 완료");
      setNewBadge({ name: "", description: "", iconUrl: "", conditionType: "", conditionValue: "" });
      fetchData();
    } catch (error) {
      console.error("등록 실패", error);
    }
  };

  const handleUpdate = async (e) => {
    e.preventDefault();
    if (!editForm.id) return;
    try {
      await updateBadgeCondition(editForm);
      alert("수정 완료");
      setEditBadgeId(null);
      setEditForm({});
      fetchData();
    } catch (error) {
      console.error("수정 실패", error);
    }
  };

  const handleDelete = async (id) => {
    if (!window.confirm("삭제하시겠습니까?")) return;
    try {
      await deleteBadge(id);
      alert("삭제 완료");
      fetchData();
    } catch (error) {
      console.error("삭제 실패", error);
    }
  };

  const handleGrantAuto = async (type) => {
    if (!type) {
      alert("조건이 없는 배지는 일괄 지급이 불가합니다.");
      return;
    }
    try {
      const res = await grantBadgesAuto(type);
      alert(res.data.message || "일괄 지급 완료");
    } catch (error) {
      console.error("일괄 지급 실패", error);
    }
  };

  const columns = [
    { label: "아이콘", style: { flexBasis: "54px", minWidth: "54px" } },
    { label: "이름", style: { flexBasis: "18%", minWidth: "90px" } },
    { label: "설명", style: { flexBasis: "32%", minWidth: "140px" } },
    { label: "획득조건", style: { flexBasis: "18%", minWidth: "80px" } },
    { label: "지급자수", style: { flexBasis: "10%", minWidth: "60px" } },
    { label: "관리", style: { flexBasis: "18%", minWidth: "140px" } },
  ];

return (
  <div className="admin-content">
    {/* 왼쪽 - 배지 리스트 */}
    <div className="badge-list">
      <h2 className="text-light-gold mb-3">배지 관리</h2>
      <TableColumnHeader columns={columns} />

      {loading ? (
        <div>로딩중...</div>
      ) : badges.length > 0 ? (
        badges.map((badge) => (
          <div key={badge.id} className="badge-table-row d-flex">
            <div className="badge-col badge-col-icon">
              <img
                src={badge.iconUrl || "/static/img/default-badge.png"}
                alt="아이콘"
                className="badge-icon-img"
              />
            </div>
            <div className="badge-col badge-col-name">{badge.name}</div>
            <div className="badge-col badge-col-desc">{badge.description}</div>
            <div className="badge-col badge-col-cond">
              {badgeConditionsMap[badge.id]?.length > 0
                ? `[${badgeConditionsMap[badge.id][0].conditionType}] ${badgeConditionsMap[badge.id][0].conditionValue}`
                : <span className="text-secondary">없음</span>}
            </div>
            <div className="badge-col">{badgeUserCount[badge.id] || 0}</div>

            <div className="badge-col badge-col-action">
              <button
                className="btn btn-outline-gold btn-xs me-1"
                onClick={() => {
                  const cond = badgeConditionsMap[badge.id]?.[0] || {};
                  setEditBadgeId(badge.id);
                  setEditForm({
                    id: cond.id,
                    badgeId: badge.id,
                    badgeName: badge.name,
                    description: badge.description,
                    conditionType: cond.conditionType,
                    conditionValue: cond.conditionValue
                  });
                }}
              >
                수정
              </button>
              <button
                className="btn btn-danger btn-xs me-1"
                onClick={() => handleDelete(badge.id)}
              >
                삭제
              </button>
              <button
                className="btn btn-success btn-xs me-1"
                onClick={() => handleGrantAuto(
                  badgeConditionsMap[badge.id]?.[0]?.conditionType
                )}
              >
                조건 일괄지급
              </button>
              <Link
                to={`/admin/badge/${badge.id}/users`}
                className="btn btn-info btn-xs"
              >
                지급자 목록
              </Link>
            </div>

            {editBadgeId === badge.id && (
              <div className="edit-form-wrap">
                <form onSubmit={handleUpdate} className="row g-2">
                  <input type="hidden" name="id" value={editForm.id} />
                  <input type="hidden" name="badgeId" value={editForm.badgeId} />
                  <FormInput
                    label="배지명"
                    name="badgeName"
                    value={editForm.badgeName}
                    onChange={(e) =>
                      setEditForm({ ...editForm, badgeName: e.target.value })
                    }
                    required
                  />
                  <FormInput
                    label="설명"
                    name="description"
                    value={editForm.description}
                    onChange={(e) =>
                      setEditForm({ ...editForm, description: e.target.value })
                    }
                    required
                  />
                  <FormSelect
                    label="조건유형"
                    name="conditionType"
                    value={editForm.conditionType}
                    onChange={(e) =>
                      setEditForm({ ...editForm, conditionType: e.target.value })
                    }
                    options={[
                      { value: "POST_COUNT", label: "게시글 수" },
                      { value: "FOLLOWER_COUNT", label: "팔로워 수" },
                      { value: "COMMENT_COUNT", label: "댓글 수" },
                    ]}
                  />
                  <FormInput
                    label="조건 값"
                    type="number"
                    name="conditionValue"
                    value={editForm.conditionValue}
                    onChange={(e) =>
                      setEditForm({ ...editForm, conditionValue: e.target.value })
                    }
                    required
                  />
                  <div className="col-12 text-end mt-2">
                    <button type="submit" className="btn btn-gold btn-sm me-2">
                      저장
                    </button>
                    <button
                      type="button"
                      className="btn btn-outline-secondary btn-sm"
                      onClick={() => setEditBadgeId(null)}
                    >
                      취소
                    </button>
                  </div>
                </form>
              </div>
            )}
          </div>
        ))
      ) : (
        <div className="text-center text-secondary py-3">
          등록된 배지가 없습니다.
        </div>
      )}
    </div>

    {/* 오른쪽 - 등록폼 */}
    <div className="badge-add-form">
      <h4 className="mb-3">배지 및 조건 등록</h4>
      <form onSubmit={handleCreate}>
        <FormInput
          label="배지명"
          name="name"
          value={newBadge.name}
          onChange={(e) =>
            setNewBadge({ ...newBadge, name: e.target.value })
          }
          required
        />
        <FormInput
          label="설명"
          name="description"
          value={newBadge.description}
          onChange={(e) =>
            setNewBadge({ ...newBadge, description: e.target.value })
          }
          required
        />
        <FormInput
          label="아이콘 URL"
          name="iconUrl"
          value={newBadge.iconUrl}
          onChange={(e) =>
            setNewBadge({ ...newBadge, iconUrl: e.target.value })
          }
        />
        <FormSelect
          label="조건유형"
          name="conditionType"
          value={newBadge.conditionType}
          onChange={(e) =>
            setNewBadge({ ...newBadge, conditionType: e.target.value })
          }
          required
          options={[
            { value: "POST_COUNT", label: "게시글 수" },
            { value: "FOLLOWER_COUNT", label: "팔로워 수" },
            { value: "COMMENT_COUNT", label: "댓글 수" },
          ]}
        />
        <FormInput
          label="조건 값"
          type="number"
          name="conditionValue"
          value={newBadge.conditionValue}
          onChange={(e) =>
            setNewBadge({ ...newBadge, conditionValue: e.target.value })
          }
          required
        />
        <div className="text-end mt-3">
          <button className="btn btn-primary btn-sm me-2">등록</button>
          <button
            type="reset"
            className="btn btn-secondary btn-sm"
            onClick={() =>
              setNewBadge({
                name: "",
                description: "",
                iconUrl: "",
                conditionType: "",
                conditionValue: ""
              })
            }
          >
            취소
          </button>
        </div>
      </form>
    </div>

    <QuickMenu />
  </div>
);

};

export default AdminBadgeManageContainer;
