module Database
  class SeederRunner

    # 外部キー制約により親テーブルである 'users' を最初に、シード実行の順序を明示的に指定
    ORDERED_TABLES = ['users', 'posts', 'followers', 'likes', 'media', 'notifications', 'private_messages', 'schedules']

    def self.run
      seeders = Database::Seeds.seeders

      # ORDERED_TABLES に記載された順序でシード処理を実行する
      ORDERED_TABLES.each do |table|
        if seeders.key?(table)
          puts "Seeding table: #{table}"
          config = seeders[table]
          dao = config[:dao] || Database::DataAccess::DAOFactory.get_dao(table)
          data = config[:data]
          if dao.respond_to?(:insert_seed_data)
            dao.insert_seed_data(data)
          else
            puts "DAO does not implement insert_seed_data for table: #{table}"
          end
        end
      end
    end
  end
end
