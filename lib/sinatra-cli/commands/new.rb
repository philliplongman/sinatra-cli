module SinatraCli
  class Main < Cli

    desc "new APP_PATH [options]", "Create a Sinatra app in APP_PATH with default configuration"

    option :skip_test, aliases: "-t", type: :boolean, banner: "",
      desc: "Don't generate an RSpec installation"

    option :erb, hide: true

    option :haml, banner: "",
      desc: "Use Haml for views, instead of ERB"

    option :slim, banner: "",
      desc: "Use Slim for views, instead of ERB"

    # Run the Project generator at `app_path` to create a new project with
    # all of the default configurations (modified by any passed options).
    # Print instructions about how to use the other gem commands.
    #
    def new(app_path, generator: Project.new(cli: self, app_path: app_path))
      app = generator.generate
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

            #{cmd :cd, path: app_path}#{cmd :server}

        and visiting localhost:3000 in your browser.
        For more information, check out the generated readme file.

      SAY
    end

  end
end
