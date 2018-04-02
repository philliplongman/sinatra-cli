module SinatraCli
  module Generators
    class Views
      include Generatable

      attr_reader :cli, :app_path, :views_path, :template_name

      def initialize(cli:, app_path: Dir.pwd, views_path: "app")
        @cli = cli
        @app_path = app_path
        @views_path = views_path
        @template_name = view_language + "_views"
        destination_root = app_path
      end

      def config
        { app_name: camelized_name }
      end

      def generate
        copy_templates from: template_name, to: views_path
        self
      end

    end
  end
end
