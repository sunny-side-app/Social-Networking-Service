class CreateNotificationsTable
  def up(db)
      db.query(<<-SQL)
      CREATE TABLE IF NOT EXISTS notifications (
        id BIGINT AUTO_INCREMENT PRIMARY KEY,
        type VARCHAR(50),
        user_id BIGINT,
        post_id BIGINT,
        like_id BIGINT,
        message_id BIGINT,
        notice_message VARCHAR(255),
        viewed_flg BOOLEAN DEFAULT FALSE,
        del_flg BOOLEAN DEFAULT FALSE,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
      SQL
  end

  def down(db)
      db.query("DROP TABLE IF EXISTS notifications;")
  end
end
