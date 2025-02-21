class CreateSchedulesTable
  def up(db)
      db.query(<<-SQL)
      CREATE TABLE IF NOT EXISTS schedules (
        id BIGINT AUTO_INCREMENT PRIMARY KEY,
        post_id BIGINT NOT NULL,
        post_date DATETIME NOT NULL,
        del_flg BOOLEAN DEFAULT FALSE,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        CONSTRAINT fk_schedules_post
          FOREIGN KEY (post_id)
          REFERENCES posts (id)
          ON DELETE CASCADE
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
      SQL
  end

  def down(db)
      db.query("DROP TABLE IF EXISTS schedules;")
  end
end
