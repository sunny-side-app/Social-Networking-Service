require 'erb'
require 'mysql2'
require 'yaml'

module DBConnection
  def self.connect
    env = ENV['APP_ENV'] || 'development'
    config_path = File.join(__dir__, '..', 'database.yml')
    yaml_content = ERB.new(File.read(config_path)).result  # ERB 展開
    config = YAML.load(yaml_content)[env]
    
    Mysql2::Client.new(
      host: config['host'],
      username: config['username'],
      password: config['password'],
      database: config['database'],
      encoding: 'utf8mb4'
    )
  end
end
