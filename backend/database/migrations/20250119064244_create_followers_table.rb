class CreateFollowersTable
  def up(db)
      db.query(<<-SQL)
      CREATE TABLE IF NOT EXISTS followers (
        id BIGINT AUTO_INCREMENT PRIMARY KEY,
        user_id BIGINT NOT NULL, -- user id who has followers
        follower_id BIGINT NOT NULL,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

        CONSTRAINT fk_followers_user
          FOREIGN KEY (user_id)
          REFERENCES users(id)
          ON DELETE CASCADE,

        CONSTRAINT fk_followers_follower
          FOREIGN KEY (follower_id)
          REFERENCES users(id)
          ON DELETE CASCADE,

        CONSTRAINT uniq_follow_relation
          UNIQUE (user_id, follower_id) -- UNIQUEで重複フォロー防止
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
      SQL
  end

  def down(db)
      db.query("DROP TABLE IF EXISTS followers;")
  end
end
