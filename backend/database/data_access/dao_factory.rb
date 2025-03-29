require_relative 'implementations/default_dao'
require_relative 'implementations/memcached_dao'

module Database
  module DataAccess
    class DAOFactory
      @dao_registry = {}

      class << self
        # 各DAOクラスをテーブル名に紐づけて登録するメソッド
        def register_dao(table_name, dao_class)
          @dao_registry[table_name.to_s] = dao_class
        end

        # 登録済みのDAOがあればそちらを返し、なければ環境設定に応じてデフォルトまたはMemcachedのDAOを返す
        def get_dao(table_name)
          table_key = table_name.to_s
          if @dao_registry.key?(table_key)
            return @dao_registry[table_key].new
          end

          if ENV['USE_MEMCACHED'] == 'true'
            Database::DataAccess::Implementations::MemcachedDAO.new(table_key)
          else
            Database::DataAccess::Implementations::DefaultDAO.new(table_key)
          end
        end

        # 登録済みDAOの一覧を返す（デバッグ用）
        def registered_daos
          @dao_registry
        end
      end
    end
  end
end
