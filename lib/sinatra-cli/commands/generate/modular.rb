module SinatraCli
  class Generate < Cli

    desc "modular [options]", "Generate a modular-style Sinatra app"

    option :erb,  hide: true

    option :haml, banner: "",
      desc: "Use Haml for views, instead of ERB."

    option :slim, banner: "",
      desc: "Use Slim for views, instead of ERB."

    # Run the modular-style app generator in the current working directory,
    # and output instructions how to start the result. ERB views will be
    # assumed unless Slim or Haml is specified.
    #
    def modular
      app = ModularApp.new(cli: self).generate
      say <<~SAY

        Success! Created #{app.camelized_name} at #{app.absolute_app_path}.
        To get started, use the command

            #{cmd :server}

        and visit localhost:3000 in your browser.
        For more information, check out the generated readme.

      SAY
    end

  end
end
