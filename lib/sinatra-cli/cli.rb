module SinatraCli
  class Cli < Thor
    include Thor::Actions

    # Import commands from discrete files
    include Commands::New
    include Commands::Generate
    include Commands::Server

    class << self
      def exit_on_failure?
        true
      end
    end

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
