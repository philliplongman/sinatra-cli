module SinatraCli
  class Cli < Thor
    include Thor::Actions
    include Generators

    class << self
      def exit_on_failure?
        true
      end

      def source_root
        File.join(SinatraCli.root, "templates")
      end

      def help(shell, subcommand = false)
        list = printable_commands(true, subcommand)
        Thor::Util.thor_classes_in(self).each do |klass|
          list += klass.printable_commands(false)
        end
        list.sort!.reject! { |e| is_help_command? e }

        shell.say "Commands:"
        shell.print_table(list, indent: 2, truncate: true)
        shell.say
        class_options_help(shell)
        shell.say "Run commands with -h or --help for more information."
      end

      def is_help_command?(command_output)
        command_output.first.end_with? "help [COMMAND]"
      end

      protected

      def dispatch(meth, given_args, given_opts, config)
        if given_args.last =~ /^(-h|--help)$/
          given_args.pop
          given_args.insert(-2, "help")
        end
      
        super(meth, given_args, given_opts, config)
      end
    end

    map %w(-h --help) => :help

    no_commands do
      # Stolen from Bundler
      def which(executable)
        if File.file?(executable) && File.executable?(executable)
          executable
        elsif paths = ENV["PATH"]
          quote = '"'.freeze
          paths.split(File::PATH_SEPARATOR).find do |path|
            path = path[1..-2] if path.start_with?(quote) && path.end_with?(quote)
            executable_path = File.expand_path(executable, path)
            if File.file?(executable_path) && File.executable?(executable_path)
              return executable_path
            end
          end
        end
      end
    end

  end
end
