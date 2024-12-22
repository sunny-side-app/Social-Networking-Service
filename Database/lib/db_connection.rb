require 'mysql2'
require 'yaml'

module DBConnection
  def self.connect
    env = ENV['APP_ENV'] || 'development'
    config_path = File.join(__dir__, '..', 'Database', 'database.yml')
    config = YAML.load_file(config_path)[env]

    Mysql2::Client.new(
      host: config['host'],
      username: config['username'],
      password: config['password'],
      database: config['database'],
      encoding: 'utf8mb4'
    )
  end
end
