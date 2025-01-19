class CreateMediaTable
  def up(db)
      db.query(<<-SQL)
      CREATE TABLE IF NOT EXISTS media (
        id BIGINT AUTO_INCREMENT PRIMARY KEY
        post_id BIGINT,
        reply_id BIGINT,
        media_type VARCHAR(50),
        media_url VARCHAR(255),
        del_flg BOOLEAN DEFAULT FALSE,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        -- どちらか片方がNULL、もう片方がNOT NULLになるユースケースを想定
        CONSTRAINT fk_media_post
          FOREIGN KEY (post_id)
          REFERENCES posts (id)
          ON DELETE CASCADE,
        CONSTRAINT fk_media_reply
          FOREIGN KEY (reply_id)
          REFERENCES replies (id)
          ON DELETE CASCADE
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
      SQL
  end

  def down(db)
      db.query("DROP TABLE IF EXISTS media;")
  end
end
