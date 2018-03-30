module SinatraCli::Generators
  class ClassicApp
    include Generatable
    include Templatable

    attr_reader :cli, :app_path

    def initialize(cli:, app_path: Dir.pwd)
      @cli = cli
      @app_path = app_path
    end

    def config
      { app_name: camelized_name }
    end

    def generate
      copy_templates_to app_path, config
      self
    end

  end
end
