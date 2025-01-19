class CreateFollowersTable
  def up(db)
      db.query(<<-SQL)
      CREATE TABLE IF NOT EXISTS followers (
        user_id BIGINT NOT NULL, -- user id who has followers
        follower_id BIGINT NOT NULL,
        PRIMARY KEY (user_id, follower_id),
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
        FOREIGN KEY (follower_id) REFERENCES users(id) ON DELETE CASCADE
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
      SQL
  end

  def down(db)
      db.query("DROP TABLE IF EXISTS followers;")
  end
end
