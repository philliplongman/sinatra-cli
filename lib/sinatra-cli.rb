# External libraries
require "active_support/concern"
require "active_support/core_ext/string/filters"
require "active_support/core_ext/string/inflections"
require "require_all"
require "thor"
require "thor/actions"

# Internal files
require_rel "sinatra-cli/version"
require_rel "sinatra-cli/cli"
require_rel "sinatra-cli/generators/concerns"
require_rel "sinatra-cli/generators"
require_rel "sinatra-cli/main"
require_rel "sinatra-cli/commands"

module SinatraCli
  ROOT = File.join(__dir__, "sinatra-cli")

  class << self
    def root
      ROOT
    end
  end
end
