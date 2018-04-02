# External libraries
require "active_support/concern"
require "active_support/core_ext/string/filters"
require "active_support/core_ext/string/inflections"
require "thor"
require "thor/actions"
require "require_all"

# Internal files
require     "sinatra-cli/version"
require     "sinatra-cli/cli"
require     "sinatra-cli/generators"
require     "sinatra-cli/main"
require_rel "sinatra-cli/commands"

module SinatraCli
  ROOT = File.join(__dir__, "sinatra-cli")

  class << self
    def root
      ROOT
    end
  end
end
