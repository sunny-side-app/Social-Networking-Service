// import React from 'react'
// import { Post } from '../types/Post'

// interface PostItemProps {
//   post: Post
// }

// function PostItem({ post }: PostItemProps) {
//   return (
//     <div style={{ border: '1px solid #ccc', margin: 8, padding: 8 }}>
//       <p>ユーザーID: {post.user_id}</p>
//       <p>内容: {post.content}</p>
//       {post.like_count !== undefined && (
//         <p>いいね数: {post.like_count}</p>
//       )}
//       <p>日時: {new Date(post.created_at).toLocaleString()}</p>
//     </div>
//   )
// }

// export default PostItem
// frontend/src/components/posts/PostItem.tsx
import React from "react";
import { Post } from "../types/Post";
import "../style/PostItem.css";

interface PostItemProps {
  post: Post;
}

function PostItem({ post }: PostItemProps) {
  return (
    <div className="postItem_container">
      <div className="postItem_header">
        <span className="postItem_user">User: {post.user_id}</span>
        {/* いいね数表示 */}
        <span className="postItem_likeCount">
          いいね: {post.like_count ?? 0}
        </span>
      </div>

      <p className="postItem_content">{post.content}</p>

      {/* created_atがあれば日時として表示 */}
      <div className="postItem_footer">
        {post.created_at && (
          <span className="postItem_createdAt">
            投稿日: {new Date(post.created_at).toLocaleString()}
          </span>
        )}
      </div>
    </div>
  );
}

export default PostItem;
