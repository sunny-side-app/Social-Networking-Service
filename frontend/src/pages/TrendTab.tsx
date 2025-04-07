import React, { useEffect, useState } from "react";
import { fetchTrendPosts } from "../services/postService";
import PostList from "../components/PostList";
import PostForm from "../components/PostForm";
import { Post } from "../types/Post";

function TrendTab() {
  const [posts, setPosts] = useState<Post[]>([]);

  useEffect(() => {
    fetchTrendPosts()
      .then((data) => setPosts(data))
      .catch(console.error);
  }, []);

    // PostForm から投稿完了→再fetchなど対応可
    const handlePostCreated = (newPost: Post) => {
      setPosts([newPost, ...posts]);
    };

  return (
    <div className="trendTab_container">
      <h3 className="trendTab_title">トレンド</h3>
      {/* (2) Pagination omitted for now */}
      <PostForm onPostCreated={handlePostCreated} />

      <PostList postList={posts} />
    </div>
  );
}

export default TrendTab;
