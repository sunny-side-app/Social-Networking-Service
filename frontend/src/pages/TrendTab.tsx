// frontend/src/pages/TrendTab.tsx
import React, { useEffect, useState } from "react";
import { fetchTrendPosts } from "../services/postService";
import PostList from "../components/PostList";

function TrendTab() {
  const [posts, setPosts] = useState<any[]>([]);

  useEffect(() => {
    fetchTrendPosts()
      .then((data) => setPosts(data))
      .catch(console.error);
  }, []);

  return (
    <div className="trendTab_container">
      <h3 className="trendTab_title">トレンド</h3>
      {/* (2) Pagination omitted for now */}
      <PostList postList={posts} />
    </div>
  );
}

export default TrendTab;
