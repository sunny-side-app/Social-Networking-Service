require_relative 'Programs/Migrate'
require_relative 'Programs/CodeGeneration'

module Commands
  # ::はモジュール(またはクラス)の中に定義されたクラスやモジュールを示すパス
  # 実行可能なコマンドを登録しておく配列
  REGISTRY = [
    Programs::Migrate,
    Programs::CodeGeneration
  ]
end
