require_rel "concerns/templatable"

module SinatraCli
  module Generators
    class Project
      # --------------------------------------------------------------------
      # Generator to produce a project with default configuration. App style
      # is modular. Gemfile, git repo, and RSpec installation are created.
      #
      # Exposed generator. Users can access it through the `new` command.
      # --------------------------------------------------------------------
      include Templatable

      attr_accessor :cli, :app_path

      def initialize(cli:, app_path:)
        @cli = cli
        @app_path = app_path
        destination_root = app_path
      end

      def generate
        create_directory
        run_generators
        self
      end

      private

      def template_variables
        {}
      end

      def create_directory
        cli.empty_directory app_path_basename unless app_path_exist?
      end

      def app_path_exist?
        (app_path == ".") || (app_path == Dir.pwd) || Dir.exist?(app_path_basename)
      end

      def run_generators
        generators.each { |g| g.new(cli: cli, app_path: app_path).generate }
      end

      def generators
        @generators ||= [GitRepo, ModularApp, test_suite].compact
      end

      def test_suite
        RSpec unless skip_test?
      end

      def skip_test?
        !!cli.options[:skip_test]
      end

    end
  end
end
