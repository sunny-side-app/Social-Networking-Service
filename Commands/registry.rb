require_relative 'Programs/Migrate'
require_relative 'Programs/CodeGeneration'
require_relative 'Programs/Seed'

module Commands
  # ::はモジュール(またはクラス)の中に定義されたクラスやモジュールを示すパス
  # 実行可能なコマンドを登録しておく配列
  REGISTRY = [
    Programs::Migrate,
    Programs::CodeGeneration,
    Programs::Seed
  ]
end
