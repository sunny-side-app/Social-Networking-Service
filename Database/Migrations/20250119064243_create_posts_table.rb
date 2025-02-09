class CreatePostsTable
  def up(db)
      db.query(<<-SQL)
      CREATE TABLE IF NOT EXISTS posts (
        id BIGINT AUTO_INCREMENT PRIMARY KEY,
        user_id BIGINT NOT NULL, -- 外部キーなし(退会しても投稿は残す)
        parent_post_id BIGINT NULL,  -- リプライ先(親投稿)のID (外部キーなし:親が削除されても子は残る)
        content TEXT NOT NULL,
        scheduled_at DATETIME,
        url VARCHAR(255),
        status VARCHAR(50),
        reply_nice_number INT DEFAULT 0,
        del_flg BOOLEAN DEFAULT FALSE,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
      SQL
  end

  def down(db)
      db.query("DROP TABLE IF EXISTS posts;")
  end
end
