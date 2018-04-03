require_rel "../cli"
require_rel "../main"

module SinatraCli
  class Generate < Cli

    # Register Generate as a subcommand of the Main cli class.
    #
    Main.class_eval do
      desc "generate ELEMENT [options]", "Run generator to add ELEMENT to project"
      subcommand "generate", Generate

      map "g" => :generate
    end

  end
end
