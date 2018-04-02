module SinatraCli
  class Generate < Cli

    desc "generate modular [options]", "Generate a modular-style Sinatra app"

    option :erb,  hide: true

    option :haml, banner: "",
      desc: "Use Haml for views, instead of ERB."

    option :slim, banner: "",
      desc: "Use Slim for views, instead of ERB."

    def modular
      app = ModularApp.new(cli: self).generate
      command = set_color("sinatra server", :cyan)
      say <<~SAY

        Success! Created #{app.camelized_name} at #{Dir.pwd}.
        To get started, use the command

            #{command}

        and visit localhost:3000 in your browser.
        For more information, check out the generated readme.

      SAY
    end

  end
end
