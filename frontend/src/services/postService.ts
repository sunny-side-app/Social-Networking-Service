import apiClient from './apiClient'
import { Post } from '../types/Post'

// トレンド用 API呼び出し
export async function fetchTrendPosts(offset=0, limit=20): Promise<Post[]> {
  const response = await apiClient.get<Post[]>('/api/posts', {
    params: { tab: 'trend', offset, limit },
  })
  return response.data
}

// フォロワー用 API呼び出し
export async function fetchFollowerPosts(
  userId: number,
  offset=0,
  limit=20
): Promise<Post[]> {
  const response = await apiClient.get<Post[]>('/api/posts', {
    params: { tab: 'followers', user_id: userId, offset, limit },
  })
  return response.data
}

export async function createPost({ content } : { content: string }): Promise<Post> {
  const response = await apiClient.post<Post>('/api/posts', { content })
  return response.data
}