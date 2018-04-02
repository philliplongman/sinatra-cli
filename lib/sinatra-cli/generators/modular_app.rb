module SinatraCli
  module Generators
    class ModularApp
      include Generatable
      include Gemable

      attr_reader :cli, :app_path

      def initialize(cli:, app_path: Dir.pwd)
        @cli = cli
        @app_path = app_path
        destination_root = app_path
      end

      def config
        { app_name: camelized_name, view_language: view_language }
      end

      def generate
        copy_templates
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
end
