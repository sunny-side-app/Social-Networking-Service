class CreateNotificationsTable
  def up(db)
      db.query(<<-SQL)
      CREATE TABLE IF NOT EXISTS notifications (
        id BIGINT AUTO_INCREMENT PRIMARY KEY
        type VARCHAR(50),
        user_id BIGINT,
        post_id BIGINT,
        reply_id BIGINT,
        nice_id BIGINT,
        message_id BIGINT,
        notice_message VARCHAR(255),
        viewed_flg BOOLEAN DEFAULT FALSE,
        del_flg BOOLEAN DEFAULT FALSE,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
        FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE,
        FOREIGN KEY (reply_id) REFERENCES replies(id) ON DELETE CASCADE,
        FOREIGN KEY (nice_id) REFERENCES nices(id) ON DELETE CASCADE,
        FOREIGN KEY (message_id) REFERENCES messages(id) ON DELETE CASCADE
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
      SQL
  end

  def down(db)
      db.query("DROP TABLE IF EXISTS notifications;")
  end
end
