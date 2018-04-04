require_rel "generators"

module SinatraCli
  class Cli < Thor
    include Thor::Actions
    include Generators

    class << self
      # On failure, let the shell or parent process know that the process
      # has failed.
      #
      def exit_on_failure?
        true
      end

      # Set folder where template files are located.
      #
      def source_root
        File.join(SinatraCli.root, "templates")
      end

      # Overwrite the Thor help command to allow custom sorting and remove
      # the help command itself from the output. Instead let users know
      # they can call the `--help` option after any command to get more
      # information. This is more like most CLI apps.
      #
      def help(shell, subcommand = false)
        list = printable_commands(true, subcommand)
        Thor::Util.thor_classes_in(self).each do |klass|
          list += klass.printable_commands(false)
        end
        list.reject! { |e| is_help_command? e }
        list.sort!.sort_by!(&custom_order)

        list.reject! { |e| is_help_command? e }

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

      # Monkey patch the Thor#dispatch method to allow users to call
      # `sinatra command --help` instead of `sinatra help command`,
      # but feed it to Thor in the order it expects
      #
      def dispatch(meth, given_args, given_opts, config)
        if given_args.last =~ /^(-h|--help)$/
          given_args.pop
          given_args.insert(-2, "help")
        end

        super(meth, given_args, given_opts, config)
      end

      # Allow classes that inherit from Cli to define a proc that #sort_by!
      # will use to sort help output. If not defined, nil will be passed
      # and #sort_by! will simply pass on an unchanged enumerator.
      #
      def custom_order
        nil
      end
    end

    map %w(-h --help) => :help

    no_commands do
      # Stolen from Bundler. Call `which` for the given executable.
      #
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

    private

    # Set text to output in cyan when output.
    #
    def cyan(text)
      set_color text, :cyan
    end

    # Return terminal command for shell output.
    #
    def cmd(command, path: nil)
      case command
      when :server
        cyan("sinatra server")
      when :classic_server
        cyan("ruby #{path}")
      when :test
        [cyan("sinatra test"), "or", cyan("sinatra spec")].join(" ")
      when :generate
        cyan("sinatra generate")
      when :cd
        path == "." ? nil : cyan("cd #{path}\n    ")
      end
    end

  end
end
