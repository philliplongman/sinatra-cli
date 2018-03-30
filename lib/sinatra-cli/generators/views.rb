module SinatraCli::Generators
  class Views
    include Generatable
    include Templatable

    attr_reader :cli, :app_path, :views_path, :template_name

    def initialize(cli:, app_path: Dir.pwd, views_path: "app")
      @cli = cli
      @app_path = app_path
      @views_path = views_path
      @template_name = cli.options[:view_language] + "_views"
    end

    def config
      { app_name: camelized_name }
    end

    def generate
      copy_templates_to File.join(app_path, views_path), config
      self
    end

  end
end
