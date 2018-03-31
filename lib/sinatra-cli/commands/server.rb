module SinatraCli::Commands::Server
  extend ActiveSupport::Concern

  included do
    desc "server [options]", "Start the server for the current directory"

    option :no_rerun,
      aliases: "-n",
      banner: "",
      desc: "Don't reload changed files with Rerun"

    def server
      raise Thor::Error, "No config.ru file" unless File.exist? "config.ru"

      gemfile = "BUNDLE_GEMFILE=#{Dir.pwd}/Gemfile"

      if options.key? :no_rerun
        exec "#{gemfile} bundle exec puma"
      else
        exec "#{gemfile} bundle exec rerun puma"
      end
    end
  end

end
