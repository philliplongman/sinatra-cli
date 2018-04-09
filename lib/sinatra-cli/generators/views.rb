require_rel "concerns/templatable"

module SinatraCli
  module Generators
    class Views
      # --------------------------------------------------------------
      # Generator to create views. Modular project folder structure is
      # assumed. Views can be created in ERB, Haml, and Slim formats.
      #
      # Hidden generator. Run by the ModularApp generator.
      # --------------------------------------------------------------
      include Templatable

      attr_reader :cli, :app_path, :views_path, :template_name

      def initialize(cli:, app_path: Dir.pwd, views_path: "app")
        @cli = cli
        @app_path = app_path
        @views_path = views_path
        @template_name = view_language + "_views"
        destination_root = app_path
      end

      def generate
        copy_templates from: template_name, to: File.join(app_path, views_path)
        self
      end

      private

      def template_variables
        { app_name: camelized_name }
      end

    end
  end
end
