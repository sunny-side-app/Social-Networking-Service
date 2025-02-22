# Rakefile

require "rake/testtask"

Rake::TestTask.new do |t|
  t.libs << "tests"            # テスト実行時に tests/ ディレクトリをライブラリパスに追加
  t.pattern = "tests/**/*_test.rb"  # サブディレクトリも含めたすべてのテストファイルを対象にする
end

task default: :test  # デフォルトタスクを :test に設定して、`rake` コマンドでテストが実行されるようにする
