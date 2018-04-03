require_rel "concerns/generatable"

module SinatraCli
  module Generators
    class Project
      include Generatable

      attr_reader :cli, :app_path

      def initialize(cli:, app_path:)
        @cli = cli
        @app_path = app_path.sub(/^\.$/, Dir.pwd)
        destination_root = app_path
      end

      def config
        {}
      end

      def generate
        create_directory
        run_generators
        self
      end

      private

      def create_directory
        cli.empty_directory app_path_name unless app_path_exist?
      end

      def app_path_exist?
        app_path == Dir.pwd || Dir.exist?(app_path_name)
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
