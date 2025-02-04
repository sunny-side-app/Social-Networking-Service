class CreateNicesTable
  def up(db)
      db.query(<<-SQL)
      CREATE TABLE IF NOT EXISTS nices (
        id BIGINT AUTO_INCREMENT PRIMARY KEY
        user_id BIGINT NOT NULL,
        nice_recipient_id BIGINT NOT NULL,
        post_id BIGINT,
        del_flg BOOLEAN DEFAULT FALSE,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

        CONSTRAINT fk_nices_post
          FOREIGN KEY (post_id)
          REFERENCES posts(id)
          ON DELETE CASCADE,

        CONSTRAINT fk_nices_user
          FOREIGN KEY (user_id)
          REFERENCES users(id)
          ON DELETE CASCADE
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
      SQL
  end

  def down(db)
      db.query("DROP TABLE IF EXISTS nices;")
  end
end
