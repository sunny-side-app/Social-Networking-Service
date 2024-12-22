module Commands
    module Command
      # モジュールをクラスにincludeすることで、
      # このCommandモジュールのClassMethodsもモジュールメソッドとして使えるようにする仕組み。
      def self.included(base)
        base.extend ClassMethods
      end
  
      module ClassMethods
        # コマンド名を取得するためのゲッター
        def command_name
          @command_name
        end
  
        # コマンド名をセット
        def set_command_name(name)
          @command_name = name
        end
      end
  
      # 全コマンドが実装すべきインターフェース
      def execute
        raise NotImplementedError, "You must implement #execute in your command."
      end
    end
  end
  