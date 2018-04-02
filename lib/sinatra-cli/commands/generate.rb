module SinatraCli
  class Generate < Cli
    include Thor::Actions

    Main.class_eval do
      desc "generate ELEMENT [options]", "Run generator to add ELEMENT to project"
      subcommand "generate", Generate
    end

  end
end
