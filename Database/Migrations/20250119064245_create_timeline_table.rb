class CreateTimelineTable
  def up(db)
      db.query(<<-SQL)
      CREATE TABLE IF NOT EXISTS timeline (
        id BIGINT AUTO_INCREMENT PRIMARY KEY
        tab_type VARCHAR(50) NOT NULL, -- e.g. Trend or Follower
        timeline_post_id BIGINT NOT NULL,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        CONSTRAINT fk_timeline_post
          FOREIGN KEY (timeline_post_id)
          REFERENCES posts (id)
          ON DELETE CASCADE
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
      SQL
  end

  def down(db)
      db.query("DROP TABLE IF EXISTS timeline;")
  end
end
