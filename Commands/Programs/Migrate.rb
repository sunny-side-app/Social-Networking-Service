require_relative '../AbstractCommand'
require 'mysql2'
require_relative '../../Database/lib/db_connection'

module Commands
  module Programs
    class Migrate < AbstractCommand
      set_command_name 'migrate'

      def execute
        # コマンド例：
        # ruby bin/console migrate --up      # 未実行のマイグレーションをすべて適用
        # ruby bin/console migrate --down    # 直近のマイグレーションをロールバック
        # ruby bin/console migrate --fresh   # DBリセット(全テーブルDROP)後、再作成
        # ruby bin/console migrate --status  # どのマイグレーションが適用済みか確認

        action = parse_action_from_args

        db = DBConnection.connect
        ensure_schema_migrations_table(db)

        case action
        when 'up'
          run_migrations_up(db)
        when 'down'
          run_migrations_down(db)
        when 'fresh'
          run_migrations_fresh(db)
        when 'status'
          show_migration_status(db)
        else
          log("No valid action provided. Use --up, --down, --fresh or --status")
        end
      end

      private

      def parse_action_from_args
        return 'up' if @flags[:up]
        return 'down' if @flags[:down]
        return 'fresh' if @flags[:fresh]
        return 'status' if @flags[:status]
        nil
      end

      def ensure_schema_migrations_table(db)
        db.query(<<-SQL)
          CREATE TABLE IF NOT EXISTS schema_migrations (
            version VARCHAR(255) PRIMARY KEY
          ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
        SQL
      end

      def run_migrations_up(db)
        migrations = Dir.glob('Database/Migrations/*.rb').sort
        migrations.each do |migration_file|
          version = File.basename(migration_file).split('_').first
          next if migrated?(db, version)

          require_relative "../../#{migration_file}"
          class_name = migration_class_name(migration_file)
          migration = Object.const_get(class_name).new
          migration.up(db)
          record_migration(db, version)
          log("Migrated: #{class_name}")
        end
      end

      def run_migrations_down(db)
        last_version = db.query("SELECT version FROM schema_migrations ORDER BY version DESC LIMIT 1").first&.[]('version')
        unless last_version
          log("No migrations to rollback")
          return
        end

        migration_file = Dir.glob("Database/Migrations/#{last_version}_*.rb").first
        require_relative "../../#{migration_file}"
        class_name = migration_class_name(migration_file)
        migration = Object.const_get(class_name).new
        migration.down(db)

        db.query("DELETE FROM schema_migrations WHERE version='#{last_version}'")
        log("Rolled back: #{class_name}")
      end

      def run_migrations_fresh(db)
        # 全テーブルをDROPしてからUPする
        tables = db.query("SHOW TABLES").map { |r| r.values.first }
        tables.each do |t|
          db.query("DROP TABLE IF EXISTS `#{t}`")
        end
        db.query("DELETE FROM schema_migrations")
        run_migrations_up(db)
      end

      def show_migration_status(db)
        all_migrations = Dir.glob('Database/Migrations/*.rb').sort
        applied = db.query("SELECT version FROM schema_migrations").map { |r| r["version"] }
        all_migrations.each do |file|
          version = File.basename(file).split('_').first
          status = applied.include?(version) ? " [x]" : " [ ]"
          log("#{status} #{File.basename(file)}")
        end
      end

      def migrated?(db, version)
        result = db.query("SELECT version FROM schema_migrations WHERE version='#{version}'")
        !result.first.nil?
      end

      def record_migration(db, version)
        db.query("INSERT INTO schema_migrations (version) VALUES('#{version}')")
      end

      def migration_class_name(file)
        parts = File.basename(file, '.rb').split('_')[1..] # バージョン(タイムスタンプ)除外
        parts.map(&:capitalize).join
      end
    end
  end
end
