import axios from 'axios'

// Viteの環境変数 or デフォルトで http://localhost:8000
const API_BASE = import.meta.env.VITE_API_BASE_URL || 'http://localhost:8000'

const apiClient = axios.create({
  baseURL: API_BASE,
  headers: { 'Content-Type': 'application/json' },
})

export default apiClient
