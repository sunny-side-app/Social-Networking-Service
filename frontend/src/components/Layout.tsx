import React from "react";
import "../style/Layout.css";

interface LayoutProps {
  children: React.ReactNode;
}

function Layout({ children }: LayoutProps) {
  return <div className="layout_container">{children}</div>;
}

export default Layout;
