require_relative '../dao_interface'
require_relative '../../lib/db_connection' 

module Database
  module DataAccess
    module Implementations
      class DefaultDAO
        include DAOInterface

        def initialize(table_name)
          @table_name = table_name
        end

        def insert_seed_data(data)
          connection = DBConnection.connect
          puts "Inserting data into #{@table_name} using DefaultDAO"
          
          data.each do |row|
            # カラム名と値の部分を作成
            columns = row.keys.map(&:to_s).join(", ")
            # 値はSQLエスケープを行い、シングルクォートで囲む
            values = row.values.map { |v| "'#{connection.escape(v.to_s)}'" }.join(", ")

            query = "INSERT INTO #{@table_name} (#{columns}) VALUES (#{values})"
            begin
              connection.query(query)
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
