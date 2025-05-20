import React from "react";
import Header from "./Header";
import Footer from "./Footer";
import SideNav from "./SideNav";
import "../style/Layout.css";


interface LayoutProps {
  children: React.ReactNode;
}

function Layout({ children }: LayoutProps) {
  return (
    <div className="layout_container">
      <Header />

      <div className="layout_body">
        <SideNav />

        {/* 中央と右側領域 */}
        <main className="layout_mainContent">
          {children}
        </main>
      </div>

      <Footer />
    </div>
  );
}

export default Layout;
