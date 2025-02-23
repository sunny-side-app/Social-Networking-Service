FROM ruby:3.3

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

# 作業ディレクトリの設定(バックエンド専用のコンテナでは backend ディレクトリのみを対象にする)
WORKDIR /usr/src/app/backend

# Gemfile, Gemfile.lock のコピーとインストール
COPY backend/Gemfile backend/Gemfile.lock ./
RUN bundle config set --global frozen 1 \
 && bundle install

# ソースコードコピー
COPY backend/ ./

# entrypoint.sh を実行可能にしておく
RUN chmod +x entrypoint.sh

# ポート公開 (Rack serverを -p 8000 で起動する例)
EXPOSE 8000

# エントリポイント設定: DB待機→マイグレーション→Rackサーバ起動
ENTRYPOINT ["./entrypoint.sh"]
