module Database
  module DataAccess
    class DAOFactory
      def self.get_dao(table_name)
        if ENV['USE_MEMCACHED'] == 'true'
          MemcachedDAO.new(table_name)
        else
          DefaultDAO.new(table_name)
        end
      end
    end
  end
end
