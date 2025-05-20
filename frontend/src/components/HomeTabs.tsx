import React from "react";
import "../style/HomeTabs.css";
import { FaFire, FaUserFriends } from "react-icons/fa";

interface HomeTabsProps {
  activeTab: "trend" | "followers";
  onChangeTab: (tab: "trend" | "followers") => void;
}

function HomeTabs({ activeTab, onChangeTab }: HomeTabsProps) {
  return (
    <div className="homeTabs_wrapper">
      <button
        className={`homeTabs_tab ${activeTab === "trend" ? "active" : ""}`} 
        onClick={() => onChangeTab("trend")}
      >
        <FaFire className="homeTabs_tabIcon" />
        トレンド
      </button>

      <button
        className={`homeTabs_tab ${activeTab === "followers" ? "active" : ""}`} 
        onClick={() => onChangeTab("followers")}
      >
        <FaUserFriends className="homeTabs_tabIcon" />
        フォロー中
      </button>
    </div>
  );
}

export default HomeTabs;
