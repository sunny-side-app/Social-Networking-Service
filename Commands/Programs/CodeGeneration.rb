require_relative '../AbstractCommand'
require 'fileutils'

module Commands
  module Programs
    class CodeGeneration < AbstractCommand
      set_command_name 'codegen'

      def execute
        # このコマンドは「新しいコマンドファイルのひな形生成」や
        # 「新しいマイグレーションファイルのひな形生成」などを行う例。
        if @flags[:help]
          print_help
          return
        end

        if @options[:command] && @options[:name]
          generate_command_file(@options[:name])
        elsif @options[:migration] && @options[:name]
          generate_migration_file(@options[:name])
        else
          log("Please specify either --command or --migration along with --name 'YourName'")
        end
      end

      private

      def print_help
        puts <<-HELP
Usage:
  ruby bin/console codegen --command --name MyCommand
    -> Generate a new command file named MyCommand.rb under Commands/Programs

  ruby bin/console codegen --migration --name create_users_table
    -> Generate a new migration file with the current timestamp + create_users_table.rb

Options:
  --command         Generate a new command class
  --migration       Generate a new migration file
  --name [NAME]     Specify the name of the class or migration
  --help            Show this help
        HELP
      end

      def generate_command_file(name)
        file_name = "#{name}.rb"
        target_path = File.join(File.dirname(__FILE__), file_name)
        if File.exist?(target_path)
          log("Command file already exists: #{target_path}")
          return
        end

        template = <<-RUBY
require_relative '../AbstractCommand'

module Commands
  module Programs
    class #{name} < AbstractCommand
      set_command_name '#{name.downcase}'

      def execute
        log("Executing #{name}")
        # Add your command logic here
      end
    end
  end
end
        RUBY

        File.write(target_path, template)
        log("Created new command file: #{target_path}")
      end

      def generate_migration_file(name)
        timestamp = Time.now.strftime('%Y%m%d%H%M%S')
        file_name = "#{timestamp}_#{name}.rb"
        migrations_dir = File.expand_path('../../../Database/Migrations', __dir__)
        FileUtils.mkdir_p(migrations_dir) unless Dir.exist?(migrations_dir)

        target_path = File.join(migrations_dir, file_name)
        if File.exist?(target_path)
          log("Migration file already exists: #{target_path}")
          return
        end

        template = <<-RUBY
class #{camelize(name)}
  def up(db)
      db.query(<<-SQL)
      CREATE TABLE IF NOT EXISTS #{table_name(name)} (
          id BIGINT AUTO_INCREMENT PRIMARY KEY
          -- TODO: define columns
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
      SQL
  end

  def down(db)
      db.query("DROP TABLE IF EXISTS #{table_name(name)};")
  end

  private

  def table_name(migration_name)
      migration_name.gsub(/^create_/, '')
  end

  def camelize(str)
      str.split('_').map(&:capitalize).join
  end
end
        RUBY

        File.write(target_path, template)
        log("Created new migration file: #{target_path}")
      end
    end
  end
end
