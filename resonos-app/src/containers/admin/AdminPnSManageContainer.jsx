import React, { useEffect, useState } from "react";
import {
  getPnsData,
  createPnsPolicy,
  updatePnsPolicy,
  deletePnsPolicy,
  createPnsSetting,
  updatePnsSettingBatch,
  deletePnsSetting,
} from "../../apis/admin"; 
import FormInput from "../../components/admin/first/FormInput";
import QuickMenu from "../../components/admin/first/QuickMenu";


const AdminPnSManageContainer = () => {
  const [policies, setPolicies] = useState([]);
  const [settings, setSettings] = useState({});
  const [loading, setLoading] = useState(false);

  // 신규 정책 입력
  const [newPolicy, setNewPolicy] = useState({ type: "", version: "", content: "" });
  const [editPolicyId, setEditPolicyId] = useState(null);
  const [editPolicy, setEditPolicy] = useState({});

  // 환경설정 값
  const [settingForm, setSettingForm] = useState({
    allow_registration: false,
    community_board_enabled: false,
    external_music_data_sync: false,
    default_theme: "dark",
    notice: "",
  });

  const fetchData = async () => {
    setLoading(true);
    try {
      const res = await getPnsData();
      const settingsMap = res.data.settings || {};
      setPolicies(res.data.policies || []);
      setSettings(settingsMap);
      setSettingForm({
        allow_registration: settingsMap.allow_registration?.value === "yes",
        community_board_enabled: settingsMap.community_board_enabled?.value === "yes",
        external_music_data_sync: settingsMap.external_music_data_sync?.value === "yes",
        default_theme: settingsMap.default_theme?.value || "dark",
        notice: settingsMap.notice?.value || "",
      });
    } catch (e) {
      console.error("정책/환경설정 데이터 불러오기 실패", e);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => { fetchData(); }, []);

  // 정책 등록
  const handleCreatePolicy = async (e) => {
    e.preventDefault();
    await createPnsPolicy(newPolicy);
    setNewPolicy({ type: "", version: "", content: "" });
    fetchData();
  };

  // 정책 수정
  const handleSavePolicy = async (id) => {
    await updatePnsPolicy(id, editPolicy);
    setEditPolicyId(null);
    setEditPolicy({});
    fetchData();
  };

  // 정책 삭제
  const handleDeletePolicy = async (id) => {
    if (!window.confirm("삭제하시겠습니까?")) return;
    await deletePnsPolicy(id);
    fetchData();
  };

  // 환경설정 저장
  const handleSaveSettings = async (e) => {
    e.preventDefault();
    await updatePnsSettingBatch({
      allow_registration: settingForm.allow_registration ? "yes" : null,
      community_board_enabled: settingForm.community_board_enabled ? "yes" : null,
      external_music_data_sync: settingForm.external_music_data_sync ? "yes" : null,
      default_theme: settingForm.default_theme,
      notice: settingForm.notice,
    });
    fetchData();
  };

  // 신규 설정 추가
  const handleCreateSetting = async (e) => {
    e.preventDefault();
    const form = e.target;
    await createPnsSetting({
      name: form.name.value,
      description: form.description.value,
      value: form.value.value,
    });
    form.reset();
    fetchData();
  };

  // 설정 삭제
  const handleDeleteSetting = async (id) => {
    if (!window.confirm("삭제하시겠습니까?")) return;
    await deletePnsSetting(id);
    fetchData();
  };

  if (loading) return <div>로딩중...</div>;

return (
  <main className="admin py-5 bg-resonos-dark">
    <div className="container admin-container max-w-1100">
      <h1 className="mb-4 text-light-gold text-start">정책/환경설정</h1>
      <div className="row g-4">
        
        {/* 정책 관리 */}
        <div className="col-12 col-lg-6">
          <div className="resonos-card p-4 text-start">
            <h3 className="mb-3 text-light-gold">정책 관리</h3>
            <form className="border rounded p-3 bg-dark mb-4 width-100" onSubmit={handleCreatePolicy}>
              <FormInput
                label="정책명"
                name="type"
                value={newPolicy.type}
                onChange={(e) => setNewPolicy({ ...newPolicy, type: e.target.value })}
                required
                containerClassName="mb-2"
              />
              <FormInput
                label="버전"
                name="version"
                value={newPolicy.version}
                onChange={(e) => setNewPolicy({ ...newPolicy, version: e.target.value })}
                containerClassName="mb-2"
              />
              <div className="mb-2">
                <label className="form-label">내용</label>
                <textarea
                  className="form-control"
                  rows="5"
                  value={newPolicy.content}
                  onChange={(e) => setNewPolicy({ ...newPolicy, content: e.target.value })}
                />
              </div>
              <div className="text-end">
                <button className="btn btn-gold">저장</button>
              </div>
            </form>

            {policies.map((p) => (
              <div key={p.id} className="policy-list mb-4 width-100">
                <h5>{p.type}</h5>
                <div className="d-flex justify-content-between align-items-center">
                  <span className="text-secondary">
                    v{p.version} / {new Date(p.updatedAt).toLocaleString()}
                  </span>
                  <button
                    className="btn btn-outline-gold btn-sm"
                    onClick={() => {
                      setEditPolicyId(p.id);
                      setEditPolicy(p);
                    }}
                  >
                    수정
                  </button>
                </div>
                {editPolicyId === p.id ? (
                  <div className="mt-2">
                    <FormInput
                      label="정책명"
                      value={editPolicy.type}
                      onChange={(e) => setEditPolicy({ ...editPolicy, type: e.target.value })}
                      required
                    />
                    <FormInput
                      label="버전"
                      value={editPolicy.version}
                      onChange={(e) => setEditPolicy({ ...editPolicy, version: e.target.value })}
                    />
                    <div className="mb-2">
                      <label className="form-label">내용</label>
                      <textarea
                        className="form-control"
                        rows="4"
                        value={editPolicy.content}
                        onChange={(e) => setEditPolicy({ ...editPolicy, content: e.target.value })}
                      />
                    </div>
                    <div className="admin right">
                      <button
                        className="btn btn-gold btn-sm me-2"
                        onClick={() => handleSavePolicy(p.id)}
                      >
                        저장
                      </button>
                      <button
                        className="btn btn-outline-secondary btn-sm"
                        onClick={() => setEditPolicyId(null)}
                      >
                        취소
                      </button>
                      <button
                        className="btn btn-outline-danger btn-sm ms-2"
                        onClick={() => handleDeletePolicy(p.id)}
                      >
                        삭제
                      </button>
                    </div>
                  </div>
                ) : (
                  <pre className="text-start">{p.content}</pre>
                )}
              </div>
            ))}
          </div>
        </div>

        {/* 환경설정 관리 */}
        <div className="col-12 col-lg-6">
          <div className="resonos-card p-4 text-start">
            <div className="admin left">
            <h3 className="mb-3 text-light-gold">서비스 환경설정</h3>

            </div>
            <form className="mb-4" onSubmit={handleSaveSettings}>
              <div className="mb-2">
                <label className="me-3">신규 가입 허용</label>
                <input
                  type="checkbox"
                  checked={settingForm.allow_registration}
                  onChange={(e) =>
                    setSettingForm({ ...settingForm, allow_registration: e.target.checked })
                  }
                />
              </div>
              <div className="mb-2">
                <label className="me-3">커뮤니티 게시판 활성화</label>
                <input
                  type="checkbox"
                  checked={settingForm.community_board_enabled}
                  onChange={(e) =>
                    setSettingForm({ ...settingForm, community_board_enabled: e.target.checked })
                  }
                />
              </div>
              <div className="mb-2">
                <label className="me-3">음악 데이터 외부 연동</label>
                <input
                  type="checkbox"
                  checked={settingForm.external_music_data_sync}
                  onChange={(e) =>
                    setSettingForm({ ...settingForm, external_music_data_sync: e.target.checked })
                  }
                />
              </div>
              <div className="mb-2 d-flex align-items-center">
                <label>기본 테마</label>
                <select
                  className="form-select w-auto ms-2"
                  value={settingForm.default_theme}
                  onChange={(e) =>
                    setSettingForm({ ...settingForm, default_theme: e.target.value })
                  }
                >
                  <option value="dark">다크</option>
                  <option value="light">라이트</option>
                </select>
              </div>
              <button className="btn btn-gold mt-3">저장</button>
            </form>

            {/* 신규 설정 추가 */}
            <form className="mb-4" onSubmit={handleCreateSetting}>
              <div className="row g-2 align-items-center mb-2">
                <div className="col">
                  <input
                    type="text"
                    className="form-control"
                    name="name"
                    placeholder="설정명"
                    required
                  />
                </div>
                <div className="col">
                  <input
                    type="text"
                    className="form-control"
                    name="description"
                    placeholder="설명"
                  />
                </div>
                <div className="col">
                  <input
                    type="text"
                    className="form-control"
                    name="value"
                    placeholder="값"
                    required
                  />
                </div>
                <div className="col-auto">
                  <button className="btn btn-outline-gold">+ 추가</button>
                </div>
              </div>
            </form>

            <h5 className="fw-bold mb-2">환경설정 전체 목록</h5>
            <table className="table table-dark table-bordered align-middle">
              <thead>
                <tr>
                  <th>ID</th>
                  <th>설명</th>
                  <th>설정값</th>
                  <th>수정일시</th>
                  <th>생성일시</th>
                  <th>관리</th>
                </tr>
              </thead>
              <tbody>
                {Object.values(settings).map((s) => (
                  <tr key={s.id}>
                    <td>{s.id}</td>
                    <td>{s.description}</td>
                    <td>{s.value}</td>
                    <td>{new Date(s.updatedAt).toLocaleString()}</td>
                    <td>{new Date(s.createdAt).toLocaleString()}</td>
                    <td>
                      <button
                        className="btn btn-outline-danger btn-sm"
                        onClick={() => handleDeleteSetting(s.id)}
                      >
                        삭제
                      </button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>

      </div>
    </div>
    <QuickMenu />
  </main>
);


};

export default AdminPnSManageContainer;
