import React from "react";
import { Post } from "../types/Post";
import "../style/PostItem.css";
import { FaReply, FaHeart } from "react-icons/fa";

interface PostItemProps {
  post: Post;
}

function PostItem({ post }: PostItemProps) {
  return (
    <div className="postItem_container">
      <div className="postItem_header">
        {/* ユーザー表示 */}
        <span className="postItem_user">@User: {post.user_id}</span>

      </div>

      {/* 本文 */}
      <div className="postItem_content">{post.content}</div>

      {/* 下部: 返信アイコン/いいねアイコン */}
      <div className="postItem_actions">
        {/* 返信アイコン */}
        <span className="postItem_reply">
          <FaReply className="postItem_icon" /> 
          2
        </span>
        {/* いいねアイコン */}
        <span className="postItem_like">
          <FaHeart className="postItem_icon" />
          {post.like_count ?? 0}
        </span>
      </div>

      {/* 投稿日時 */}
      <div className="postItem_footer">
        投稿日: {new Date(post.created_at).toLocaleString()}
      </div>
    </div>
  );
}

export default PostItem;
