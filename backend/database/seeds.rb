module Database
  module Seeds
    @seeders = {}

    # DSL の定義メソッド
    # table_name: 対象テーブル名
    # columns: カラム定義（例: [:id, :name, :email]）
    # dao: （オプション）特定の DAO インスタンスを渡す場合に利用可能
    # &block: シードデータを生成するためのブロック（返り値は Array 等、必要なメソッドに応答するオブジェクト）
    def self.define(table_name, columns:, dao: nil, &block)
      data = block.call
      @seeders[table_name] = { columns: columns, data: data, dao: dao }
    end

    def self.seeders
      @seeders
    end
  end
end
