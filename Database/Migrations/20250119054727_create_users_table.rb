class CreateUsersTable
  def up(db)
      db.query(<<-SQL)
      CREATE TABLE IF NOT EXISTS users (
        id BIGINT AUTO_INCREMENT PRIMARY KEY
        user_name VARCHAR(255) NOT NULL,
        mail_address VARCHAR(255) NOT NULL UNIQUE,
        password VARCHAR(255) NOT NULL,
        age INT,
        location VARCHAR(255),
        hobby TEXT,
        profile_image VARCHAR(255),
        following_number INT DEFAULT 0,
        follower_number INT DEFAULT 0,
        influencer_flg BOOLEAN DEFAULT FALSE,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
      SQL
  end

  def down(db)
      db.query("DROP TABLE IF EXISTS users;")
  end
end
