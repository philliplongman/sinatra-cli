module SinatraCli::Generators
  class GitRepo
    include Generatable

    attr_reader :cli, :app_path

    def initialize(cli:, app_path: Dir.pwd)
      @cli = cli
      @app_path = app_path
      destination_root = app_path
    end

    def generate
      cli.run "git init" if git_present?
      self
    end

    private

    # Stolen from Bundler
    def git_present?
      return @git_present if defined? @git_present
      @git_present = cli.which("git") || cli.which("git.exe")
    end

  end
end
