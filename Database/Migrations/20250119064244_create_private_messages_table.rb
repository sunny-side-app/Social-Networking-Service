class CreatePrivateMessagesTable
  def up(db)
      db.query(<<-SQL)
      CREATE TABLE IF NOT EXISTS private_messages (
        id BIGINT AUTO_INCREMENT PRIMARY KEY,
        sender_id BIGINT NOT NULL,
        recipient_id BIGINT NOT NULL,
        message_content TEXT NOT NULL,
        message_url VARCHAR(255),
        del_flg BOOLEAN DEFAULT FALSE,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        CONSTRAINT fk_pm_account
          FOREIGN KEY (sender_id)
          REFERENCES users (id)
          ON DELETE CASCADE,
        CONSTRAINT fk_pm_recipient
          FOREIGN KEY (recipient_id)
          REFERENCES users (id)
          ON DELETE CASCADE
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
      SQL
  end

  def down(db)
      db.query("DROP TABLE IF EXISTS private_messages;")
  end
end
