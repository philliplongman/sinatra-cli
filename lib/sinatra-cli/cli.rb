require "thor"

module SinatraCli
  class Cli < Thor

    desc "new DIR", "create a modular Sinatra app in DIR"
    options name: :string
    def new(dir)
      Project.modular(dir, options).generate
    end

    desc "basic DIR", "create a one-file classic Sinatra app in DIR"
    options name: :string
    def basic(dir)
      Project.basic(dir, options).generate
    end

  end
end
