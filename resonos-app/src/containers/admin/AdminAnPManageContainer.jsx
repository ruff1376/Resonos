import React, { useEffect, useState } from "react";
import SearchForm from "../../components/admin/first/SearchForm";
import TableColumnHeader from "../../components/admin/first/TableColumnHeader";
import Pagination from "../../components/admin/Pagination";
import FormInput from "../../components/admin/first/FormInput";
import {
  getAnPData,
  createApiKey,
  deleteApiKey,
  toggleApiKey,
  createPlugin,
  deletePlugin,
  togglePlugin,
  updateApiKey,
  updatePlugin
} from "../../apis/admin";
import QuickMenu from "../../components/admin/first/QuickMenu";

const PAGE_SIZE = 5; // 페이지당 아이템 수

const AdminAnPManageContainer = () => {
  const [apiKeys, setApiKeys] = useState([]);
  const [plugins, setPlugins] = useState([]);
  const [loading, setLoading] = useState(false);

  const [editApiId, setEditApiId] = useState(null);
  const [editPluginId, setEditPluginId] = useState(null);
  const [editFormData, setEditFormData] = useState({});

  const [newApi, setNewApi] = useState({ apiKey: "", provider: "", secret: "" });
  const [newPlugin, setNewPlugin] = useState({ name: "", configJson: "" });

  // 검색/페이지네이션 상태
  const [keyword, setKeyword] = useState("");
  const [apiPage, setApiPage] = useState(1);
  const [pluginPage, setPluginPage] = useState(1);

  const fetchData = async () => {
    setLoading(true);
    try {
      const res = await getAnPData();
      setApiKeys(res.data.apiKeys || []);
      setPlugins(res.data.plugins || []);
    } finally {
      setLoading(false);
    }
  };
  useEffect(() => { fetchData(); }, []);

  // 신규 등록
  const handleCreateApi = async (e) => { e.preventDefault(); await createApiKey(newApi); setNewApi({ apiKey:"", provider:"", secret:"" }); fetchData(); };
  const handleCreatePlugin = async (e) => { e.preventDefault(); await createPlugin(newPlugin); setNewPlugin({ name:"", configJson:"" }); fetchData(); };

  // 삭제/토글
  const handleDeleteApi = async (id) => { if(window.confirm("삭제하시겠습니까?")){ await deleteApiKey(id); fetchData(); }};
  const handleToggleApi = async (id) => { await toggleApiKey(id); fetchData(); };
  const handleDeletePlugin = async (id) => { if(window.confirm("삭제하시겠습니까?")){ await deletePlugin(id); fetchData(); }};
  const handleTogglePlugin = async (id) => { await togglePlugin(id); fetchData(); };

  // 수정모드 진입
  const startEdit = (type, item) => {
    if (type === "api") { setEditApiId(item.id); }
    else { setEditPluginId(item.id); }
    setEditFormData(item);
  };
  // 수정폼 변경
  const handleEditChange = (e) => {
    const { name, value } = e.target;
    setEditFormData(prev => ({ ...prev, [name]: value }));
  };
  // 수정 저장
  const saveEdit = async (type) => {
    if (type === "api") {
      await updateApiKey(editFormData.id, editFormData);
      setEditApiId(null);
    } else {
      await updatePlugin(editFormData.id, editFormData);
      setEditPluginId(null);
    }
    setEditFormData({});
    fetchData();
  };
  // 수정 취소
  const cancelEdit = () => { setEditApiId(null); setEditPluginId(null); setEditFormData({}); };

  const apiColumns = [
    { label: "번호", style: { flexBasis:"5%", minWidth: "40px"} },
    { label: "API 키", style: { flexBasis:"25%", minWidth: "200px"} },
    { label: "설명", style: { flexBasis:"20%", minWidth: "150px"} },
    { label: "등록일", style: { flexBasis:"12%", minWidth: "100px"} },
    { label: "상태", style: { flexBasis:"10%", minWidth: "80px"} },
    { label: "관리", style: { flexBasis:"18%", minWidth: "120px"} }
  ];
  const pluginColumns = [
    { label: "번호", style: { flexBasis:"5%", minWidth: "40px"} },
    { label: "이름", style: { flexBasis:"20%", minWidth: "120px"} },
    { label: "설정", style: { flexBasis:"25%", minWidth: "150px"} },
    { label: "등록일", style: { flexBasis:"12%", minWidth: "100px"} },
    { label: "상태", style: { flexBasis:"10%", minWidth: "80px"} },
    { label: "관리", style: { flexBasis:"18%", minWidth: "120px"} }
  ];

  // 🔍 검색 필터 적용 데이터
  const filteredApis = apiKeys.filter(k =>
    k.apiKey.includes(keyword) || k.provider?.includes(keyword)
  );
  const filteredPlugins = plugins.filter(p =>
    p.name.includes(keyword) || p.configJson?.includes(keyword)
  );

  // 페이지네이션 slice
  const pagedApis = filteredApis.slice((apiPage - 1) * PAGE_SIZE, apiPage * PAGE_SIZE);
  const pagedPlugins = filteredPlugins.slice((pluginPage - 1) * PAGE_SIZE, pluginPage * PAGE_SIZE);

  return (
    <div className="container" style={{ maxWidth: 950 }}>
      <h2 className="mb-3 text-light-gold">오픈 API 및 Plugin 관리</h2>

      {/* 검색폼 */}
      <SearchForm onSearch={(kw) => { setKeyword(kw); setApiPage(1); setPluginPage(1); }} />

      {loading ? <div>로딩중...</div> : (
        <>
          {/* API 키 등록 */}
          <div className="resonos-card p-4 mb-4">
            <h3 className="mb-3">API 관리</h3>
            <form className="row g-2 mb-3" onSubmit={handleCreateApi}>
              <FormInput label="API Key" name="apiKey" value={newApi.apiKey} onChange={e=>setNewApi({...newApi,[e.target.name]:e.target.value})} containerClassName="col-md-3" />
              <FormInput label="설명" name="provider" value={newApi.provider} onChange={e=>setNewApi({...newApi,[e.target.name]:e.target.value})} containerClassName="col-md-3" />
              <FormInput label="Secret" name="secret" value={newApi.secret} onChange={e=>setNewApi({...newApi,[e.target.name]:e.target.value})} containerClassName="col-md-3" />
              <div className="col-md-3 text-end"><button className="btn btn-gold btn-sm">등록</button></div>
            </form>

            <TableColumnHeader columns={apiColumns} />
            {pagedApis.length > 0 ? pagedApis.map((api, idx) => (
              <div key={api.id} className="list-group-item bg-dark text-light d-flex flex-nowrap align-items-center text-center justify-content-center">
                {apiColumns.map((col, colIdx) => {
                  let cellValue = "";
                  switch (colIdx) {
                    case 0: cellValue = (apiPage - 1) * PAGE_SIZE + idx + 1; break;
                    case 1: cellValue = (editApiId === api.id) ? <input name="apiKey" value={editFormData.apiKey} onChange={handleEditChange} className="form-control form-control-sm" /> : api.apiKey; break;
                    case 2: cellValue = (editApiId === api.id) ? <input name="provider" value={editFormData.provider} onChange={handleEditChange} className="form-control form-control-sm" /> : api.provider; break;
                    case 3: cellValue = api.createdAt?.slice(0,10); break;
                    case 4: cellValue = (<button className={`btn btn-sm ${api.enabled ? 'btn-outline-gold' : 'btn-gold'}`} onClick={() => handleToggleApi(api.id)}>{api.enabled ? '비활성' : '활성'}</button>); break;
                    case 5: cellValue = (editApiId === api.id) ? (
                      <>
                        <button className="btn btn-gold btn-sm me-1" onClick={()=>saveEdit("api")}>저장</button>
                        <button className="btn btn-outline-secondary btn-sm" onClick={cancelEdit}>취소</button>
                      </>
                    ) : (
                      <>
                        <button className="btn btn-outline-gold btn-sm me-1" onClick={()=>startEdit("api", api)}>수정</button>
                        <button className="btn btn-outline-danger btn-sm" onClick={()=>handleDeleteApi(api.id)}>삭제</button>
                      </>
                    ); break;
                  }
                  return <div key={colIdx} style={col.style}>{cellValue}</div>;
                })}
              </div>
            )) : <div className="text-center text-secondary py-3">등록된 API 키가 없습니다.</div>}

            {/* Pagination */}
            <Pagination
              page={apiPage}
              first={1}
              last={Math.ceil(filteredApis.length / PAGE_SIZE)}
              prev={apiPage > 1 ? apiPage - 1 : 1}
              next={apiPage < Math.ceil(filteredApis.length / PAGE_SIZE) ? apiPage + 1 : Math.ceil(filteredApis.length / PAGE_SIZE)}
              start={1}
              end={Math.ceil(filteredApis.length / PAGE_SIZE)}
              pageUri={"#"}
              onPageChange={setApiPage}
            />
          </div>

          {/* 플러그인 */}
          <div className="resonos-card p-4">
            <h3 className="mb-3">플러그인 관리</h3>
            <form className="row g-2 mb-3" onSubmit={handleCreatePlugin}>
              <FormInput label="이름" name="name" value={newPlugin.name} onChange={e=>setNewPlugin({...newPlugin,[e.target.name]:e.target.value})} containerClassName="col-md-4" />
              <FormInput label="설정(JSON)" name="configJson" value={newPlugin.configJson} onChange={e=>setNewPlugin({...newPlugin,[e.target.name]:e.target.value})} containerClassName="col-md-6" />
              <div className="col-md-2 text-end"><button className="btn btn-gold btn-sm">등록</button></div>
            </form>

            <TableColumnHeader columns={pluginColumns} />
            {pagedPlugins.length > 0 ? pagedPlugins.map((plugin, idx) => (
              <div key={plugin.id} className="list-group-item bg-dark text-light d-flex flex-nowrap align-items-center text-center justify-content-center">
                {pluginColumns.map((col, colIdx) => {
                  let cellValue = "";
                  switch (colIdx) {
                    case 0: cellValue = (pluginPage - 1) * PAGE_SIZE + idx + 1; break;
                    case 1: cellValue = (editPluginId === plugin.id) ? <input name="name" value={editFormData.name} onChange={handleEditChange} className="form-control form-control-sm" /> : plugin.name; break;
                    case 2: cellValue = (editPluginId === plugin.id) ? <input name="configJson" value={editFormData.configJson} onChange={handleEditChange} className="form-control form-control-sm" /> : plugin.configJson; break;
                    case 3: cellValue = plugin.createdAt?.slice(0,10); break;
                    case 4: cellValue = (<button className={`btn btn-sm ${plugin.enabled ? 'btn-outline-gold' : 'btn-gold'}`} onClick={() => handleTogglePlugin(plugin.id)}>{plugin.enabled ? '비활성' : '활성'}</button>); break;
                    case 5: cellValue = (editPluginId === plugin.id) ? (
                      <>
                        <button className="btn btn-gold btn-sm me-1" onClick={()=>saveEdit("plugin")}>저장</button>
                        <button className="btn btn-outline-secondary btn-sm" onClick={cancelEdit}>취소</button>
                      </>
                    ) : (
                      <>
                        <button className="btn btn-outline-gold btn-sm me-1" onClick={()=>startEdit("plugin", plugin)}>수정</button>
                        <button className="btn btn-outline-danger btn-sm" onClick={()=>handleDeletePlugin(plugin.id)}>삭제</button>
                      </>
                    ); break;
                  }
                  return <div key={colIdx} style={col.style}>{cellValue}</div>;
                })}
              </div>
            )) : <div className="text-center text-secondary py-3">등록된 플러그인이 없습니다.</div>}

            <Pagination
              page={pluginPage}
              first={1}
              last={Math.ceil(filteredPlugins.length / PAGE_SIZE)}
              prev={pluginPage > 1 ? pluginPage - 1 : 1}
              next={pluginPage < Math.ceil(filteredPlugins.length / PAGE_SIZE) ? pluginPage + 1 : Math.ceil(filteredPlugins.length / PAGE_SIZE)}
              start={1}
              end={Math.ceil(filteredPlugins.length / PAGE_SIZE)}
              pageUri={"#"}
              onPageChange={setPluginPage}
            />
            <QuickMenu />
          </div>
        </>
      )}
    </div>
  );
};

export default AdminAnPManageContainer;
