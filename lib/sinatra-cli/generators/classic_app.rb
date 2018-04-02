module SinatraCli
  module Generators
    class ClassicApp
      include Generatable

      attr_reader :cli, :app_path

      def initialize(cli:, app_path: Dir.pwd)
        @cli = cli
        @app_path = app_path
        destination_root = app_path
      end

      def config
        { app_name: camelized_name }
      end

      def generate
        copy_templates
        self
      end

      def projectname
        underscored_name
      end

    end
  end
end
