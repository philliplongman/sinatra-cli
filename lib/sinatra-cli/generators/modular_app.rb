require_rel "concerns/gemable"
require_rel "concerns/generatable"

module SinatraCli
  module Generators
    class ModularApp
      # ----------------------------------------------------------------------
      # Generator to produce a modular-style app. Environment is loaded
      # from files in `config` folder. Business logic is contained in
      # `app` folder. Reloading is configured. Gemfile is created.
      #
      # Exposed generator. Users can access it through the `generate` command.
      # ----------------------------------------------------------------------
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
