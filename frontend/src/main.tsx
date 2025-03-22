import React from 'react'
import ReactDOM from 'react-dom/client'

const App = () => <h1>フロントエンド疎通確認OK</h1>

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
)
