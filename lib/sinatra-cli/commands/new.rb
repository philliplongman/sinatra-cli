module SinatraCli::Commands::New
  extend ActiveSupport::Concern

  included do
    desc "new APP_PATH [options]", "Create a modular-style Sinatra app in APP_PATH"

    option :classic,
      banner: "",
      desc: "Generate a bare-bones, classic-style project instead"

    def new(dir)
      Project.new(dir, options).build
    end
  end

end
