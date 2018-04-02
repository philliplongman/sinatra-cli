module SinatraCli
  class Main < Cli
    # Import commands from discrete files
    include Commands::New
    include Commands::Generate
    include Commands::Server

  end
end
