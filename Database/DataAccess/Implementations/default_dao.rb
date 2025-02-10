module Database
  module DataAccess
    class DefaultDAO
      include DAOInterface

      def initialize(table_name)
        @table_name = table_name
      end

      def insert_seed_data(data)
        puts "Inserting data into #{@table_name} using DefaultDAO"
        # ここに実際の DB 挿入ロジックを実装します（例: SQL の実行など）
        data.each { |row| puts "Inserted: #{row.inspect}" }
      end
    end
  end
end
