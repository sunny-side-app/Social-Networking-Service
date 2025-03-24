import React from 'react'
import { Post } from '../types/Post'

interface PostItemProps {
  post: Post
}

function PostItem({ post }: PostItemProps) {
  return (
    <div style={{ border: '1px solid #ccc', margin: 8, padding: 8 }}>
      <p>ユーザーID: {post.user_id}</p>
      <p>内容: {post.content}</p>
      {post.like_count !== undefined && (
        <p>いいね数: {post.like_count}</p>
      )}
      <p>日時: {new Date(post.created_at).toLocaleString()}</p>
    </div>
  )
}

export default PostItem
