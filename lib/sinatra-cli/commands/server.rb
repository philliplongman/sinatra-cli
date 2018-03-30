module SinatraCli::Commands::Server
  extend ActiveSupport::Concern

  included do
    desc "server [options]", "Start the server for the current directory"

    option "no-rerun",
      aliases: "-r",
      banner: "",
      desc: "Start the server without Rerun"

    def server
      raise Thor::Error, "No config.ru file" unless File.exist? "config.ru"

      gemfile = "BUNDLE_GEMFILE=#{Dir.pwd}/Gemfile"

      if options["no-rerun"]
        exec "#{gemfile} bundle exec puma"
      else
        exec "#{gemfile} bundle exec rerun puma"
      end
    end
  end

end
