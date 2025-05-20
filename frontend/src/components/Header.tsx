import React from "react";
import "../style/Header.css"; // .header_container など定義

function Header() {
  return (
    <header className="header_container">
      <div className="header_inner">
        <h1 className="header_title">SNS App</h1>
      </div>
    </header>
  );
}

export default Header;
