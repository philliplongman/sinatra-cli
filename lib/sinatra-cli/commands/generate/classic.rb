module SinatraCli
  class Generate < Cli

    desc "generate classic", "Generate a classic-style Sinatra app"

    def classic
      app = ClassicApp.new(cli: self).generate
      command = set_color("ruby #{app.underscored_name}.rb", :cyan)
      say <<~SAY

        Success! Created #{app.camelized_name} at #{app.absolute_app_path}
        To get started, use the command

            #{command}

        and visit localhost:4567 in your browser.

      SAY
    end

  end
end
