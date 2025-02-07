class CreateLogsTable
  def up(db)
      db.query(<<-SQL)
      CREATE TABLE IF NOT EXISTS logs (
        id BIGINT AUTO_INCREMENT PRIMARY KEY,
        user_id BIGINT NULL,
        resource_type VARCHAR(50) NOT NULL,
        resource_id BIGINT NULL,          
        action VARCHAR(100) NOT NULL,     
        details TEXT,                     
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
      SQL
  end

  def down(db)
      db.query("DROP TABLE IF EXISTS logs;")
  end
end
