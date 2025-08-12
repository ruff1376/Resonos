// src/layouts/AdminLayout.jsx
import React from "react";
import styles from "../components/admin/css/admin.module.css"; // 한 번만 import

export default function AdminLayout({ children }) {
  return (
    <div className={styles.container}>
      {children}
    </div>
  );
}
