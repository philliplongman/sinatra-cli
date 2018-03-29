module SinatraCli::Generators
  class GitRepo
    include Generatable

    def generate
      thor.run "git init" if git_present?
      self
    end

    private

    # Stolen from Bundler
    def git_present?
      return @git_present if defined? @git_present
      @git_present = which("git") || which("git.exe")
    end

  end
end
