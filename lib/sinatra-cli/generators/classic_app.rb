require_rel "concerns/generatable"

module SinatraCli
  module Generators
    class ClassicApp
      #
      # Generator to produce a classic-style app. Ruby code is contained in
      # one main file. A `public` folder is created with empty JS and CSS
      # files. A `view` folder is created with a single `index.erb` file and
      # no layout file. Neither a Gemfile nor a git repo is created.
      #
      # Exposed generator. Users can access it through the `generate` command.
      #
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

      # Copy template files from `templates/classic_app` and return self
      # so the shell output can reference it.
      #
      def generate
        copy_templates
        self
      end

    end
  end
end
