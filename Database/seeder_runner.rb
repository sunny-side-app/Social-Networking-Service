module Database
  class SeederRunner
    def self.run
      Database::Seeds.seeders.each do |table, config|
        puts "Seeding table: #{table}"
        # DSL 定義時に dao オプションが渡されていない場合は、DAOFactory 経由で取得
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
