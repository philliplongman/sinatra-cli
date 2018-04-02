module SinatraCli
  class Main < Cli

    desc "server [options]", "Start the server for the current directory"

    option :no_rerun,
      aliases: "-n",
      banner: "",
      desc: "Don't reload changed files with Rerun"

    def server
      raise Thor::Error, "No config.ru file" unless File.exist? "config.ru"

      gemfile = File.join(Dir.pwd, "/Gemfile")

      if options.key? :no_rerun
        exec "BUNDLE_GEMFILE=#{gemfile} bundle exec puma"
      else
        exec "BUNDLE_GEMFILE=#{gemfile} bundle exec rerun puma"
      end
    end
    
  end
end
