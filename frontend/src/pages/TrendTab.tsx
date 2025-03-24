import React, { useEffect, useState } from 'react'
import { Post } from '../types/Post'
import { fetchTrendPosts } from '../services/postService'
import PostItem from '../components/PostItem'

function TrendTab() {
  const [posts, setPosts] = useState<Post[]>([])

  useEffect(() => {
    fetchTrendPosts()
      .then(data => setPosts(data))
      .catch(err => console.error(err))
  }, [])

  return (
    <div>
      <h2>トレンド (いいね数が多い投稿)</h2>
      {posts.map(post => (
        <PostItem key={post.id} post={post} />
      ))}
    </div>
  )
}

export default TrendTab
