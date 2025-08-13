// src/layouts/AdminLayout.jsx
import React from "react";
import "../styles/admin.css"; // admin 전용 CSS

export default function AdminLayout({ children }) {
  return (
    <div className="admin">
      <div className="container">
        {children}
      </div>
    </div>
  );
}
