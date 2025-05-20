import React, { useState } from "react";
import "../style/PostForm.css";
import { Post } from "../types/Post";
import { createPost } from "../services/postService";

interface PostFormProps {
  onPostCreated: (newPost: Post) => void;
}

function PostForm({ onPostCreated }: PostFormProps) {
  const [content, setContent] = useState("");

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!content.trim()) return;

    try {
      const newPost = await createPost({ content });
      onPostCreated(newPost);
      setContent("");
    } catch (error) {
      console.error(error);
    }
  };

  return (
    <form className="postForm_container" onSubmit={handleSubmit}>
      <textarea
        className="postForm_textarea"
        value={content}
        onChange={(e) => setContent(e.target.value)}
        placeholder="What's on your mind?"
      />
      <button type="submit" className="postForm_submit">
        Post
      </button>
    </form>
  );
}

export default PostForm;
