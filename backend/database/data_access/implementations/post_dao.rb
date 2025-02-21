require_relative '../dao_interface'
require_relative '../../lib/db_connection'

module Database
  module DataAccess
    module Implementations
      class PostDAO
        include DAOInterface

        def initialize
          @table_name = "posts"
          @connection = DBConnection.connect
        end

        def timeline_trend(limit, offset)
          sql = <<-SQL
            SELECT p.*, COUNT(l.id) AS like_count
            FROM posts p
            LEFT JOIN likes l ON p.id = l.post_id
            WHERE DATE(p.created_at) = CURDATE()
            GROUP BY p.id
            ORDER BY like_count DESC
            LIMIT ? OFFSET ?
          SQL
          statement = @connection.prepare(sql)
          statement.execute(limit, offset).to_a
        end

        def timeline_followers(user_id, limit, offset)
          sql = <<-SQL
            SELECT p.*
            FROM posts p
            WHERE p.user_id IN (
              SELECT followed_id FROM follows WHERE follower_id = ?
            )
            ORDER BY p.created_at DESC
            LIMIT ? OFFSET ?
          SQL
          statement = @connection.prepare(sql)
          statement.execute(user_id, limit, offset).to_a
        end

        def insert_seed_data(data)
          data.each do |row|
            columns = row.keys.map(&:to_s).join(", ")
            values = row.values.map { |v| "'#{@connection.escape(v.to_s)}'" }.join(", ")
            query = "INSERT INTO #{@table_name} (#{columns}) VALUES (#{values})"
            begin
              @connection.query(query)
              puts "Inserted: #{row.inspect}"
            rescue => e
              puts "Failed to insert #{row.inspect}: #{e.message}"
            end
          end
        end
      end
    end
  end
end

# このファイルの末尾で、DAOFactory に自動登録する
Database::DataAccess::DAOFactory.register_dao("posts", Database::DataAccess::Implementations::PostDAO)
