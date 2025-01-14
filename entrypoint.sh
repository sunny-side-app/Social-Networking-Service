#!/bin/sh

# 環境変数 (docker-compose.yml で指定) を使ってDBホスト/ポートを待機
DB_HOST="${DB_HOST:-db}"
DB_PORT="${DB_PORT:-3306}"

echo "Waiting for DB to be ready at ${DB_HOST}:${DB_PORT} ..."
# wait-for-it.shの呼び出し:DBが接続可能になるまで 待ち、次の処理へ進む
# (./wait-for-it.sh のパスは実際の配置場所に合わせて修正)
./wait-for-it.sh "${DB_HOST}:${DB_PORT}" --timeout=30 --strict -- \
  echo "DB is up!"

# --- マイグレーション実行 ---
echo "Running migrations via Migrate.rb ..."
# bundle exec で Rubyスクリプト実行
bundle exec ruby Commands/Programs/Migrate.rb

# --- Rack サーバ起動 ---
echo "Starting Rack server on 0.0.0.0:8000..."
# メインプロセスとして常駐するため、exec で Rack サーバを起動
exec bundle exec rackup -p 8000 -o 0.0.0.0
