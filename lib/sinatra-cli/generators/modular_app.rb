module SinatraCli::Generators
  class ModularApp
    include Generatable
    include Gemable
    include Templatable

    attr_reader :cli, :app_path, :view_language

    def initialize(cli:, app_path: Dir.pwd)
      @cli = cli
      @app_path = app_path
      @view_language = cli.options[:view_language]
    end

    def config
      { app_name: camelized_name, view_language: view_language }
    end

    def generate
      copy_templates_to app_path, config
      generate_views
      bundle_gems
      self
    end

    private

    def generate_views
      Views.new(cli: cli, app_path: app_path).generate
    end

  end
end
