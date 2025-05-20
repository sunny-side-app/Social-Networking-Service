import React, { useState } from "react";
// Layout, Header, Footer は E-Commerceから移植 or sharedディレクトリを流用
import Layout from "../components/Layout";
import Header from "../components/Header";
import Footer from "../components/Footer";

// 既存のタブコンポーネント
import HomeTabs from "../components/HomeTabs";
// 2つのタブ画面
import TrendTab from "./TrendTab";
import FollowerTab from "./FollowerTab";

// HomePage.css (or .scss) で .homepage_container 等を定義
import "../style/HomePage.css";

function HomePage() {
  const [activeTab, setActiveTab] = useState<"trend" | "followers">("trend");

  return (
    <Layout>
      <Header />

      {/* メインのコンテナ */}
      <div className="homepage_container">
        {/* タイトルや検索欄等を配置したければここに */}
        <div className="homepage_title_container">
          <h2>ホームタイムライン</h2>
          {/* もし検索を入れたいなら <SearchInput ...> など */}
        </div>

        {/* タブ切り替え */}
        <div className="homepage_tabs_container">
          <HomeTabs
            activeTab={activeTab}
            onChangeTab={(tab) => setActiveTab(tab)}
          />
        </div>

        {/* タブごとのコンポーネントを表示 */}
        <div className="homepage_tabContent_container">
          {activeTab === "trend" && <TrendTab />}
          {activeTab === "followers" && <FollowerTab userId={1} />}
        </div>
      </div>
    </Layout>
  );
}

export default HomePage;
