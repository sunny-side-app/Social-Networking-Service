require_relative 'programs/migrate'
require_relative 'programs/code_generation'
require_relative 'programs/seed'

module Commands
  # ::はモジュール(またはクラス)の中に定義されたクラスやモジュールを示すパス
  # 実行可能なコマンドを登録しておく配列
  REGISTRY = [
    Programs::Migrate,
    Programs::CodeGeneration,
    Programs::Seed
  ]
end
