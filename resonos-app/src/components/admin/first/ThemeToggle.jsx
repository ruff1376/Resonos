import React, { useState, useEffect } from "react";

/**
 * ThemeToggle
 * - 다크/라이트 모드를 전환하는 버튼
 * - 현재 테마 상태를 localStorage에 저장하여, 새로고침 후에도 유지
 * - 어떤 UI 영역에도 쉽게 배치 가능 (Navbar, QuickMenu, Footer 등)
 */
const ThemeToggle = ({ className = "" }) => {
  const [theme, setTheme] = useState(() => {
    // 로컬스토리지에 저장된 테마가 있으면 사용, 없으면 기본값 'dark'
    return localStorage.getItem("theme") || "dark";
  });

  // theme 변경 시 HTML의 data-theme 속성 변경 + 저장
  useEffect(() => {
    document.documentElement.setAttribute("data-theme", theme);
    localStorage.setItem("theme", theme);
  }, [theme]);

  // 버튼 클릭 시 theme 상태 토글
  const toggleTheme = () => {
    setTheme((prev) => (prev === "dark" ? "light" : "dark"));
  };

<button
  className={`admin theme-toggle-btn ${className || ''}`}
  onClick={toggleTheme}
  aria-label="Toggle Theme"
>
  {theme === "dark" ? "☀️ Light" : "🌙 Dark"}
</button>

};

export default ThemeToggle;
