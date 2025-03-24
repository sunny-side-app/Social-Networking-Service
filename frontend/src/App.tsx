import React from 'react'
import { Routes, Route } from 'react-router-dom'
import HomePage from './pages/HomePage'
// import LoginPage from './pages/LoginPage'
import NotFoundPage from './pages/NotFoundPage'

function App() {
  return (
    <Routes>
      {/* ルートパス (/) で HomePage を表示 */}
      <Route path="/" element={<HomePage />} />

      {/* 例: ログインページ */}
      {/* <Route path="/login" element={<LoginPage />} /> */}

      {/* どのパスにもマッチしなかった場合 */}
      <Route path="*" element={<NotFoundPage />} />
    </Routes>
  )
}

export default App
