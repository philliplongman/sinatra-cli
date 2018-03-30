module SinatraCli::Generators
  class Views
    include Generatable
    include Templatable

    attr_reader :cli, :app_path, :views_path, :template_dir

    def initialize(cli:, app_path: Dir.pwd, views_path: "app", template_dir: "erb_views")
      @cli = cli
      @app_path = app_path
      @views_path = views_path
      @template_dir = template_dir
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
