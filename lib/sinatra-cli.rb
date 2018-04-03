# External libraries
require "require_all"
require "thor"
require "thor/actions"

# Internal files
require_rel "sinatra-cli"

module SinatraCli
  ROOT = File.join(__dir__, "sinatra-cli")

  class << self
    def root
      ROOT
    end
  end
end
