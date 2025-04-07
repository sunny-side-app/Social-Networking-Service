import React from "react";
import "../style/SideNav.css";

function SideNav() {
  return (
    <nav className="sideNav_container">
      <ul>
        <li>
          <a href="/" className="sideNav_link">Home</a>
        </li>
        <li>
          <a href="/notifications" className="sideNav_link">Notifications</a>
        </li>
        <li>
          <a href="/messages" className="sideNav_link">Private Messages</a>
        </li>
        <li>
          <a href="/profile" className="sideNav_link">Profile</a>
        </li>
      </ul>
    </nav>
  );
}

export default SideNav;
