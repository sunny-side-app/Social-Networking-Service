class CreateFollowingsTable
  def up(db)
      db.query(<<-SQL)
      CREATE TABLE IF NOT EXISTS followings (
        user_id BIGINT NOT NULL, -- user id who has followings
        following_id BIGINT NOT NULL,
        PRIMARY KEY (user_id, following_id),
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
        FOREIGN KEY (following_id) REFERENCES users(id) ON DELETE CASCADE
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
      SQL
  end

  def down(db)
      db.query("DROP TABLE IF EXISTS followings;")
  end
end
