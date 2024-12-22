module Commands
    class Argument
      # コマンドが使用できる引数オプションを定義する際のビルダークラス
      attr_reader :name, :required, :has_value
  
      def initialize(name, required: false, has_value: false)
        @name = name
        @required = required
        @has_value = has_value
      end
  
      # ここにBuilderパターン的なメソッドを追加して、柔軟に設定できるようにする例
      def self.build(name)
        new(name)
      end
  
      def required!
        @required = true
        self
      end
  
      def with_value!
        @has_value = true
        self
      end
    end
  end
  