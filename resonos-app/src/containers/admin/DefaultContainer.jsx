import React, { useEffect, useState } from "react";
import SearchForm from "../../components/admin/first/SearchForm";
import TableColumnHeader from "../../components/admin/first/TableColumnHeader";
import Pagination from "../../components/admin/Pagination";
import {
  getAnPData,
  createApiKey,
  deleteApiKey,
  toggleApiKey,
  createPlugin,
  deletePlugin,
  togglePlugin
} from "../../apis/admin";

const AdminAnPManageContainer = () => {
  const [apiKeys, setApiKeys] = useState([]);
  const [plugins, setPlugins] = useState([]);
  const [loading, setLoading] = useState(false);

  const [page, setPage] = useState(1);
  const [size] = useState(10);
  const [paginationApi, setPaginationApi] = useState({ totalPages: 1, total: 0 });
  const [paginationPlugin, setPaginationPlugin] = useState({ totalPages: 1, total: 0 });

  // 검색 키워드
  const [keyword, setKeyword] = useState("");
  const pageUri = `/admin/AnP?keyword=${encodeURIComponent(keyword)}`;

  // 신규 입력 값
  const [newApi, setNewApi] = useState({ apiKey: "", provider: "", secret: "" });
  const [newPlugin, setNewPlugin] = useState({ name: "", configJson: "" });

  const fetchData = async () => {
    setLoading(true);
    try {
      const res = await getAnPData();
      // 실제로는 서버에서 페이징된 결과를 받아야 하지만,
      // 여기선 전체목록 받아서 slice
      setApiKeys(res.data.apiKeys || []);
      setPlugins(res.data.plugins || []);
      setPaginationApi({
        total: res.data.apiKeys?.length || 0,
        totalPages: 1,
        page
      });
      setPaginationPlugin({
        total: res.data.plugins?.length || 0,
        totalPages: 1,
        page
      });
    } catch (e) {
      console.error("데이터 조회 실패", e);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchData();
  }, [keyword, page]);

  const handleSearch = (kw) => {
    setKeyword(kw);
    setPage(1);
  };

  // API 키 CRUD
  const handleCreateApi = async (e) => {
    e.preventDefault();
    await createApiKey(newApi);
    setNewApi({ apiKey: "", provider: "", secret: "" });
    fetchData();
  };
  const handleDeleteApi = async (id) => {
    if (!window.confirm("삭제하시겠습니까?")) return;
    await deleteApiKey(id);
    fetchData();
  };
  const handleToggleApi = async (id) => {
    await toggleApiKey(id);
    fetchData();
  };

  // 플러그인 CRUD
  const handleCreatePlugin = async (e) => {
    e.preventDefault();
    await createPlugin(newPlugin);
    setNewPlugin({ name: "", configJson: "" });
    fetchData();
  };
  const handleDeletePlugin = async (id) => {
    if (!window.confirm("삭제하시겠습니까?")) return;
    await deletePlugin(id);
    fetchData();
  };
  const handleTogglePlugin = async (id) => {
    await togglePlugin(id);
    fetchData();
  };

  /** 컬럼 정의 */
  const apiColumns = [
    { label: "번호", style: { flexBasis: "5%", minWidth: "40px" } },
    { label: "API 키", style: { flexBasis: "25%", minWidth: "200px" } },
    { label: "설명", style: { flexBasis: "20%", minWidth: "150px" } },
    { label: "등록일", style: { flexBasis: "12%", minWidth: "100px" } },
    { label: "상태", style: { flexBasis: "10%", minWidth: "80px" } },
    { label: "관리", style: { flexBasis: "10%", minWidth: "80px" } }
  ];

  const pluginColumns = [
    { label: "번호", style: { flexBasis: "5%", minWidth: "40px" } },
    { label: "이름", style: { flexBasis: "20%", minWidth: "120px" } },
    { label: "설정", style: { flexBasis: "25%", minWidth: "150px" } },
    { label: "등록일", style: { flexBasis: "12%", minWidth: "100px" } },
    { label: "상태", style: { flexBasis: "10%", minWidth: "80px" } },
    { label: "관리", style: { flexBasis: "10%", minWidth: "80px" } }
  ];

  return (
    <div className="container" style={{ maxWidth: 950 }}>
      <h2 className="mb-3 text-light-gold">오픈 API 및 Plugin 관리</h2>
      <span style={{ color: "#D4B97F" }}>※ API 키 노출에 주의하세요.</span>

      <SearchForm onSearch={handleSearch} />

      {loading ? (
        <div>로딩중...</div>
      ) : (
        <>
          {/* API 키 관리 */}
          <div className="resonos-card p-4 mb-5">
            <h3 className="mb-3 text-light-gold">API 관리</h3>
            <form className="mb-4 d-flex gap-2 align-items-center" onSubmit={handleCreateApi}>
              <input
                className="api-key-input"
                placeholder="신규 API 키"
                value={newApi.apiKey}
                onChange={e => setNewApi({ ...newApi, apiKey: e.target.value })}
              />
              <input
                className="api-key-input"
                placeholder="설명"
                value={newApi.provider}
                onChange={e => setNewApi({ ...newApi, provider: e.target.value })}
              />
              <input
                className="api-key-input"
                placeholder="API Secret"
                value={newApi.secret}
                onChange={e => setNewApi({ ...newApi, secret: e.target.value })}
              />
              <button className="btn btn-gold btn-sm" type="submit">등록</button>
            </form>

            <TableColumnHeader columns={apiColumns} />
            {apiKeys.length > 0 ? apiKeys.map((api, idx) => (
              <div key={api.id} className="list-group-item bg-dark text-light d-flex text-center">
                <div style={apiColumns[0].style}>{idx + 1}</div>
                <div style={apiColumns[1].style}>{api.apiKey}</div>
                <div style={apiColumns[2].style}>{api.provider}</div>
                <div style={apiColumns[3].style}>{api.createdAt?.slice(0, 10)}</div>
                <div style={apiColumns[4].style}>
                  <button className={`btn btn-sm ${api.enabled ? 'btn-outline-gold' : 'btn-gold'}`} onClick={() => handleToggleApi(api.id)}>
                    {api.enabled ? "비활성" : "활성"}
                  </button>
                </div>
                <div style={apiColumns[5].style}>
                  <button className="btn btn-outline-gold btn-sm" onClick={() => handleDeleteApi(api.id)}>삭제</button>
                </div>
              </div>
            )) : (
              <div className="text-center text-secondary py-3">등록된 API 키가 없습니다.</div>
            )}

            <Pagination
              page={page}
              first={1}
              last={paginationApi.totalPages}
              prev={page > 1 ? page - 1 : 1}
              next={page < paginationApi.totalPages ? page + 1 : paginationApi.totalPages}
              start={1}
              end={paginationApi.totalPages}
              pageUri={pageUri}
              onPageChange={setPage}
            />
          </div>

          {/* 플러그인 관리 */}
          <div className="resonos-card p-4">
            <h3 className="mb-3 text-light-gold">플러그인 관리</h3>
            <form className="mb-4 d-flex gap-2 align-items-center" onSubmit={handleCreatePlugin}>
              <input
                className="api-key-input"
                placeholder="플러그인 이름"
                value={newPlugin.name}
                onChange={e => setNewPlugin({ ...newPlugin, name: e.target.value })}
              />
              <input
                className="api-key-input"
                placeholder="설정(JSON)"
                value={newPlugin.configJson}
                onChange={e => setNewPlugin({ ...newPlugin, configJson: e.target.value })}
              />
              <button className="btn btn-gold btn-sm" type="submit">등록</button>
            </form>

            <TableColumnHeader columns={pluginColumns} />
            {plugins.length > 0 ? plugins.map((plugin, idx) => (
              <div key={plugin.id} className="list-group-item bg-dark text-light d-flex text-center">
                <div style={pluginColumns[0].style}>{idx + 1}</div>
                <div style={pluginColumns[1].style}>{plugin.name}</div>
                <div style={pluginColumns[2].style}>{plugin.configJson}</div>
                <div style={pluginColumns[3].style}>{plugin.createdAt?.slice(0, 10)}</div>
                <div style={pluginColumns[4].style}>
                  <button className={`btn btn-sm ${plugin.enabled ? 'btn-outline-gold' : 'btn-gold'}`} onClick={() => handleTogglePlugin(plugin.id)}>
                    {plugin.enabled ? "비활성" : "활성"}
                  </button>
                </div>
                <div style={pluginColumns[5].style}>
                  <button className="btn btn-outline-gold btn-sm" onClick={() => handleDeletePlugin(plugin.id)}>삭제</button>
                </div>
              </div>
            )) : (
              <div className="text-center text-secondary py-3">등록된 플러그인이 없습니다.</div>
            )}

            <Pagination
              page={page}
              first={1}
              last={paginationPlugin.totalPages}
              prev={page > 1 ? page - 1 : 1}
              next={page < paginationPlugin.totalPages ? page + 1 : paginationPlugin.totalPages}
              start={1}
              end={paginationPlugin.totalPages}
              pageUri={pageUri}
              onPageChange={setPage}
            />
          </div>
        </>
      )}
    </div>
  );
};

export default AdminAnPManageContainer;
