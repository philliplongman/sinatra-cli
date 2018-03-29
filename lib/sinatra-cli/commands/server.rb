module SinatraCli::Commands::Server
  extend ActiveSupport::Concern

  included do
    desc "server", "Start a Sinatra app"

    option :rerun,
      type: :boolean,
      default: true,
      desc: "Reload the app with Rerun"

    def server
      raise Thor::Error, "No config.ru file" unless File.exist? "config.ru"

      gemfile = "BUNDLE_GEMFILE=#{Dir.pwd}/Gemfile "

      if options[:rerun]
        exec "#{gemfile} bundle exec rerun puma"
      else
        exec "#{gemfile} bundle exec puma"
      end
    end
  end

end
