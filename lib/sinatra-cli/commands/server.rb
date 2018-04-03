module SinatraCli
  class Main < Cli

    desc "server [options]", "Start the server for the current directory"

    option :no_reload, aliases: "-n", banner: "",
      desc: "Don't reload changed files with Rerun"

    # Start the server. Reloading files with Rerun is enabled by default.
    #
    def server
      raise Thor::Error, "No config.ru file" unless File.exist? "config.ru"

      gemfile = File.join(Dir.pwd, "/Gemfile")

      if options.key? :no_reload
        exec "BUNDLE_GEMFILE=#{gemfile} bundle exec puma"
      else
        exec "BUNDLE_GEMFILE=#{gemfile} bundle exec rerun puma"
      end
    end

    map "s" => :server

  end
end
