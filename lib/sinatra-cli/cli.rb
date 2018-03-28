# External libraries
require "active_support/concern"
require "active_support/core_ext/string/filters"
require "active_support/core_ext/string/inflections"
require "thor"
require "thor/actions"

# Internal files
require "sinatra-cli/generators"
require "sinatra-cli/commands"

module SinatraCli
  class Cli < Thor
    # Import commands from discrete files
    include Commands::New
    include Commands::Generate

  end
end
