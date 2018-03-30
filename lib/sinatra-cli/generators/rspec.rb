module SinatraCli::Generators
  class RSpec
    include Generatable
    include Gemable
    include Templatable

    attr_reader :cli, :app_path, :template_name

    def initialize(cli:, app_path: Dir.pwd, template_name: "rspec")
      @cli = cli
      @app_path = app_path
      @template_name = template_name
    end

    def config
      { app_name: camelized_name }
    end

    def generate
      copy_templates_to app_path, config
      add_gems_to_group :test,
        :launchy, :rspec, :fuubar, capybara: { require: "capybara/rspec" }
      bundle_gems
      self
    end

  end
end
