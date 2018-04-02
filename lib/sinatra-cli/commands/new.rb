module SinatraCli
  class Main < Cli

    desc "new APP_PATH [options]", "Create a modular-style Sinatra app in APP_PATH"

    option :classic, banner: "",
      desc: "Generate a bare-bones, classic-style project instead"

    option :skip_test, aliases: "-t", type: :boolean, banner: "",
      desc: "Don't generate an RSpec installation"

    option :erb, hide: true

    option :haml, banner: "",
      desc: "Use Haml for views, instead of ERB."

    option :slim, banner: "",
      desc: "Use Slim for views, instead of ERB."

    def new(app_path)
      app = Project.new(cli: self, app_path: app_path).generate
      say <<~SAY

        Success! Created #{app.camelized_name} at #{app.absolute_app_path}
        Inside that directory, you can run several commands:

            #{cmd :server}
              Starts the development server

            #{cmd :test}
              Starts the test runner

            #{cmd :generate}
              Add elements you may have skipped, like RSpec or Webpack

        We suggest that you begin by typing:

            #{cmd :cd, app_path}#{cmd :server}

        and visiting localhost:3000 in your browser.
        For more information, check out the generated readme file.

      SAY
    end

  end
end
