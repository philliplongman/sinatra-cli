require_rel "concerns/templatable"

module SinatraCli
  module Generators
    class ClassicApp
      # ----------------------------------------------------------------------
      # Generator to produce a classic-style app. Ruby code is contained in
      # one main file. A `public` folder is created with empty JS and CSS
      # files. A `view` folder is created with a single `index.erb` file and
      # no layout file. Neither a Gemfile nor a git repo is created.
      #
      # Exposed generator. Users can access it through the `generate` command.
      # ----------------------------------------------------------------------
      include Templatable

      attr_accessor :cli, :app_path

      def initialize(cli:, app_path: Dir.pwd)
        @cli = cli
        @app_path = app_path
      end

      def generate
        copy_templates
        self
      end

      private

      def template_variables
        { app_name: camelized_name }
      end

    end
  end
end
