require_relative '../abstract_command'
require_relative '../../database/seeds'
require_relative '../../database/seeder_runner'
require_relative '../../database/data_access/dao_factory'

module Commands
  module Programs
    class Seed < Commands::AbstractCommand
      set_command_name 'seed'

      # コマンドライン引数を返す（今回は引数不要）
      def self.get_arguments
        []
      end

      # コマンド実行時のメイン処理
      def execute
        run_all_seeds
        0  # 終了コード 0 を返す
      end

      private

      # シード定義ファイルを読み込み、SeederRunner 経由で全シード処理を実行する
      def run_all_seeds
        # シード定義ファイルの格納ディレクトリを指定（プロジェクトルートからの相対パス）
        seeds_dir = File.expand_path('../../Database/Seeds', __dir__)
        
        # ディレクトリ内の Ruby ファイル (*.rb) をすべて読み込む
        Dir.glob(File.join(seeds_dir, '*.rb')).each do |seed_file|
          require seed_file
        end

        # ここで Database::Seeds.define によって登録されたシード定義がすべて揃っている前提です。
        # SeederRunner によって各シードのデータが DAO 経由で挿入されます。
        Database::SeederRunner.run
      end
    end
  end
end
