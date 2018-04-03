require_rel "../cli"
require_rel "../main"

module SinatraCli
  class Generate < Cli

    Main.class_eval do
      desc "generate ELEMENT [options]", "Run generator to add ELEMENT to project"
      subcommand "generate", Generate
    end

  end
end
