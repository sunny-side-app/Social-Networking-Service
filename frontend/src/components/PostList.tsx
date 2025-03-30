import React from "react";
import PostItem from "./PostItem";

interface Post {
  id: number;
  user_id: number;
  content: string;
}

interface PostListProps {
  postList: Post[];
}

function PostList({ postList }: PostListProps) {
  return (
    <div className="postList_container">
      {postList.map((post) => (
        <PostItem key={post.id} post={post} />
      ))}
      {postList.length === 0 && (
        <p className="text-gray-500">投稿がありません</p>
      )}
    </div>
  );
}

export default PostList;
