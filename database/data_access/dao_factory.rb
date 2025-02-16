require_relative 'implementations/default_dao'
require_relative 'implementations/memcached_dao'

module Database
  module DataAccess
    class DAOFactory
      def self.get_dao(table_name)
        if ENV['USE_MEMCACHED'] == 'true'
          Database::DataAccess::Implementations::MemcachedDAO.new(table_name)
        else
          Database::DataAccess::Implementations::DefaultDAO.new(table_name)
        end
      end
    end
  end
end
