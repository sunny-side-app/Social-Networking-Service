class CreateRepliesTable
  def up(db)
      db.query(<<-SQL)
      CREATE TABLE IF NOT EXISTS replies (
        id BIGINT AUTO_INCREMENT PRIMARY KEY
        post_id BIGINT NOT NULL,
        user_id BIGINT NOT NULL,
        reply_content TEXT NOT NULL,
        reply_url VARCHAR(255),
        reply_nice_number INT DEFAULT 0,
        del_flg BOOLEAN DEFAULT FALSE,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        PRIMARY KEY (post_id, id),
        FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE,
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
      SQL
  end

  def down(db)
      db.query("DROP TABLE IF EXISTS replies;")
  end
end
