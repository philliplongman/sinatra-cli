require "require_all"

module SinatraCli
  ROOT = File.join(__dir__, "sinatra-cli")

  class << self
    def root
      ROOT
    end
  end
end

# External libraries
require "active_support/concern"
require "active_support/core_ext/string/filters"
require "active_support/core_ext/string/inflections"
require "thor"
require "thor/actions"

# Internal files
require "sinatra-cli/version"
require "sinatra-cli/cli"
require "sinatra-cli/generators"
require "sinatra-cli/commands"
require "sinatra-cli/main"
