// components/admin/first/TabsGeneric.jsx
import React from 'react';

const TabsGeneric = ({
  tabs = [],            // [{ key, label, count?, ... }]
  activeKey,            // 현재 활성화 키
  onChange,              // 탭 클릭 시 실행 (key 전달)
  className = 'nav nav-tabs mb-4',   // 스타일 클래스
  renderTabLabel,        // 탭 라벨 출력 커스터마이즈 (tab) => JSX
}) => {
 return (
  <ul className={`admin ${className}`}>
    {tabs.map((tab) => (
      <li className="nav-item" key={tab.key}>
        <button
          className={`nav-link ${activeKey === tab.key ? 'active' : ''}`}
          onClick={() => onChange && onChange(tab.key)}
        >
          {renderTabLabel
            ? renderTabLabel(tab)
            : (
              <>
                {tab.label}
                {tab.count !== undefined && (
                  <> <span>({tab.count})</span></>
                )}
              </>
            )}
        </button>
      </li>
    ))}
  </ul>
);

};

export default TabsGeneric;
