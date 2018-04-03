require_rel "concerns/generatable"

module SinatraCli
  module Generators
    class Views
      #
      # Generator to create views. Modular project folder structure is
      # assumed. Views can be created in ERB, Haml, and Slim formats.
      #
      # Hidden generator. Run by the ModularApp generator.
      #
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
        copy_templates from: template_name, to: File.join(app_path, views_path)
        self
      end

    end
  end
end
