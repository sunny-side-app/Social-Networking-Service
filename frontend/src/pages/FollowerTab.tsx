import React, { useEffect, useState } from 'react'
import { Post } from '../types/Post'
import { fetchFollowerPosts } from '../services/postService'
import PostItem from '../components/PostItem'

interface FollowerTabProps {
  userId: number
}

function FollowerTab({ userId }: FollowerTabProps) {
  const [posts, setPosts] = useState<Post[]>([])

  useEffect(() => {
    fetchFollowerPosts(userId)
      .then(data => setPosts(data))
      .catch(err => console.error(err))
  }, [userId])

  return (
    <div>
      <h2>フォロワー投稿 (userId={userId})</h2>
      {posts.map(post => (
        <PostItem key={post.id} post={post} />
      ))}
    </div>
  )
}

export default FollowerTab
