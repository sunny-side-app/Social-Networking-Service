require_relative '../AbstractCommand'
require 'mysql2'
require_relative '../../Database/lib/db_connection'

module Commands
  module Programs
    class Migrate < AbstractCommand
      set_command_name 'migrate'

      def execute
        # コマンド例：
        # ruby bin/console migrate --up             # 未実行のマイグレーションをすべて適用
        # ruby bin/console migrate --down           # 直近のマイグレーションを1つロールバック
        # ruby bin/console migrate --fresh          # DBリセット(全テーブルDROP)後、再作成
        # ruby bin/console migrate --status         # どのマイグレーションが適用済みか確認
        # ruby bin/console migrate --init           # 初期化: schema_migrations テーブルがなければ作成し、run_migrations_up
        # ruby bin/console migrate --rollback 2     # 2ステップ前までロールバック

        action = parse_action_from_args

        db = DBConnection.connect

        # ここで schema_migrations テーブルの存在を確実にする
        # (ただし `--init` の場合も必ず先に ensure_schema_migrations_table を呼ぶ)
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
        when 'init'
          run_migrations_init(db)
        when 'rollback'
          steps = @options[:rollback_steps] || 1
          run_migrations_rollback(db, steps)
        else
          log("No valid action provided. Use --up, --down, --fresh, --status, --init, or --rollback [n]")
        end
      end

      private

      # ▼▼▼ パラメータ解析: --init, --rollback [n] を追加 ▼▼▼
      def parse_action_from_args
        return 'up'       if @flags[:up]
        return 'down'     if @flags[:down]
        return 'fresh'    if @flags[:fresh]
        return 'status'   if @flags[:status]
        return 'init'     if @flags[:init]
        return 'rollback' if @flags[:rollback]
        nil
      end

      # ▼▼▼ schema_migrations テーブルが無ければ作る ▼▼▼
      def ensure_schema_migrations_table(db)
        db.query(<<-SQL)
          CREATE TABLE IF NOT EXISTS schema_migrations (
            version VARCHAR(255) PRIMARY KEY
          ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
        SQL
      end

      # ▼▼▼ init用メソッド: schema_migrationsが無いとき作成→そのまま up ▼▼▼
      def run_migrations_init(db)
        log("Running migrations init...")
        # ensure_schema_migrations_table ですでにテーブルを作成済みなので
        # あとは up と同様に未実行のマイグレーションを実行するだけ
        run_migrations_up(db)
      end

      # ▼▼▼ up: 未実行のマイグレーションをすべて適用 ▼▼▼
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

      # ▼▼▼ down: 直近1つだけロールバック ▼▼▼
      def run_migrations_down(db)
        last_version = db.query("SELECT version FROM schema_migrations ORDER BY version DESC LIMIT 1").first&.[]('version')
        unless last_version
          log("No migrations to rollback")
          return
        end

        rollback_single(db, last_version)
      end

      # ▼▼▼ rollback: 複数ステップロールバック (--rollback n) ▼▼▼
      def run_migrations_rollback(db, steps = 1)
        log("Rolling back #{steps} migration(s)...")

        # schema_migrations から実行済みバージョンを新しい順に取得
        applied_versions = db.query("SELECT version FROM schema_migrations ORDER BY version DESC").map { |r| r['version'] }

        count = 0
        applied_versions.each do |version|
          break if count >= steps

          rollback_single(db, version)
          count += 1
        end

        log("Rollback completed.")
      end

      # ▼▼▼ 1つのバージョンをロールバックする共通処理 ▼▼▼
      def rollback_single(db, version)
        # 該当ファイルを探す
        migration_file = Dir.glob("Database/Migrations/#{version}_*.rb").first
        unless migration_file
          log("Could not find migration file for version: #{version}")
          return
        end

        require_relative "../../#{migration_file}"
        class_name = migration_class_name(migration_file)
        migration = Object.const_get(class_name).new

        migration.down(db)
        db.query("DELETE FROM schema_migrations WHERE version='#{version}'")

        log("Rolled back: #{class_name}")
      end

      # ▼▼▼ fresh: 全テーブルDROP→全マイグレーションUP ▼▼▼
      def run_migrations_fresh(db)
        tables = db.query("SHOW TABLES").map { |r| r.values.first }
        tables.each do |t|
          db.query("DROP TABLE IF EXISTS `#{t}`")
        end
        db.query("DELETE FROM schema_migrations")

        run_migrations_up(db)
      end

      # ▼▼▼ status: マイグレーション状況の表示 ▼▼▼
      def show_migration_status(db)
        all_migrations = Dir.glob('Database/Migrations/*.rb').sort
        applied = db.query("SELECT version FROM schema_migrations").map { |r| r["version"] }

        all_migrations.each do |file|
          version = File.basename(file).split('_').first
          status = applied.include?(version) ? " [x]" : " [ ]"
          log("#{status} #{File.basename(file)}")
        end
      end

      # ▼▼▼ DBに記録済みのバージョンをチェック ▼▼▼
      def migrated?(db, version)
        result = db.query("SELECT version FROM schema_migrations WHERE version='#{version}'")
        !result.first.nil?
      end

      # ▼▼▼ 1件のバージョンを schema_migrations にINSERT ▼▼▼
      def record_migration(db, version)
        db.query("INSERT INTO schema_migrations (version) VALUES('#{version}')")
      end

      # ▼▼▼ migrationファイル名からクラス名を導出 ▼▼▼
      def migration_class_name(file)
        parts = File.basename(file, '.rb').split('_')[1..] # 先頭要素(タイムスタンプ)以外
        parts.map(&:capitalize).join
      end
    end
  end
end
