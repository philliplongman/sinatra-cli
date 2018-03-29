module SinatraCli
  class Cli < Thor
    include Thor::Actions

    class << self
      def exit_on_failure?
        true
      end
    end

    # Import commands from discrete files
    include Commands::New
    include Commands::Generate
    include Commands::Server

  end
end
