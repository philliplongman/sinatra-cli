module SinatraCli
  module Generators
    class GitRepo
      include Generatable

      attr_reader :cli, :app_path

      def initialize(cli:, app_path: Dir.pwd)
        @cli = cli
        @app_path = app_path
        destination_root = app_path
      end

      def generate
        create_repo if git
        self
      end

      private

      def create_repo
        cli.inside(app_path) { cli.run "git init" }
      end

      # Stolen from Bundler
      def git
        return @git if defined? @git
        @git = cli.which("git") || cli.which("git.exe")
      end

    end
  end
end
