export interface Post {
  id: number
  user_id: number
  content: string
  created_at: string
  updated_at?: string
  like_count?: number
}
