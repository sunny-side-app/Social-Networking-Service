require_relative 'Command'
require_relative 'Argument'

module Commands
  class AbstractCommand
    include Command

    def initialize(args = [])
      @raw_args = args
      @options = {}
      @flags = {}
      @positional_args = []
      parse_arguments
    end

    # すべてのコマンドライン引数を解析して、
    # @optionsや@flags, @positional_args等に格納する
    def parse_arguments
      # 例として非常に簡易な実装
      # --key value 形式 → options[key] = value
      # --flag 形式 → flags[flag] = true
      # それ以外 → positional_args << 引数
      until @raw_args.empty?
        arg = @raw_args.shift
        if arg.start_with?('--')
          # --something の場合
          key = arg.sub(/^--/, '') # 先頭の--を取り除く
          # 次の要素がオプション値っぽいかどうか
          if @raw_args.first && !@raw_args.first.start_with?('--')
            # 次の要素が値とみなして取り出す
            value = @raw_args.shift
            @options[key.to_sym] = value
          else
            # 値をとらないフラグ
            @flags[key.to_sym] = true
          end
        else
          # ふつうの引数
          @positional_args << arg
        end
      end
    end

    # ログ出力用のヘルパーメソッド
    def log(msg)
      puts "[#{self.class.command_name}] #{msg}"
    end
  end
end
