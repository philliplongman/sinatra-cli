require_rel "concerns/generatable"

module SinatraCli
  module Generators
    class GitRepo
      # ---------------------------------------------------
      # Generator to initialize a git repo in new projects.
      #
      # Hidden generator. Run by the Project generator.
      # ---------------------------------------------------
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

      # Initialize a git repo in app_path.
      #
      def create_repo
        cli.inside(app_path) { cli.run "git init" }
      end

      # Check that `git` is present on the system before trying to use it.
      #
      def git
        return @git if defined? @git
        @git = cli.which("git") || cli.which("git.exe")
      end

    end
  end
end
