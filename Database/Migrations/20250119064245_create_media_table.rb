class CreateMediaTable
  def up(db)
      db.query(<<-SQL)
      CREATE TABLE IF NOT EXISTS media (
        id BIGINT AUTO_INCREMENT PRIMARY KEY,
        post_id BIGINT,
        media_type VARCHAR(50),
        media_url VARCHAR(255),
        del_flg BOOLEAN DEFAULT FALSE,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
      SQL
  end

  def down(db)
      db.query("DROP TABLE IF EXISTS media;")
  end
end
