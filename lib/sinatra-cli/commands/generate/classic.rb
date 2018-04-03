module SinatraCli
  class Generate < Cli

    desc "generate classic", "Generate a classic-style Sinatra app"

    # Run the classic-style app generator in the current working directory,
    # and output instructions how to start the result.
    #
    def classic
      app = ClassicApp.new(cli: self).generate
      say <<~SAY

        Success! Created #{app.camelized_name} at #{app.absolute_app_path}
        To get started, type

            #{cmd :classic_server, path: (app.underscored_name + ".rb")}

        and visit localhost:4567 in your browser.

      SAY
    end

  end
end