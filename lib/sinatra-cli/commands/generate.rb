module SinatraCli::Commands::Generate
  extend ActiveSupport::Concern

  included do
    desc "generate ELEMENT", "Run generator to add ELEMENT to project"
    subcommand "generate", Command
  end

  class Command < Thor
    include Thor::Actions
    include SinatraCli::Generators

    no_commands do
      def self.source_root
        File.expand_path "../templates", File.dirname(__FILE__)
      end

      def templates_folder
        self.class.source_root
      end
    end

    # MODULAR ------------------------------------------------------------------
    desc "modular", "Generate a modular-style Sinatra app"

    def modular
      app = ModularApp.new(cli: self).generate
      command = set_color("sinatra server", :cyan)
      say <<~SAY

        Success! Created #{app.camelized_name} at #{Dir.pwd}.
        To get started, run the command

            #{command}

        and visit localhost:3000 in your browser.
        For more information, check out the generated readme.

      SAY
    end

    # CLASSIC ------------------------------------------------------------------
    desc "classic", "Generate a classic-style Sinatra app"

    def classic
      app = ClassicApp.new(cli: self).generate
      command = set_color("ruby #{app.underscored_name}.rb", :cyan)
      say <<~SAY

        Success! Created #{app.camelized_name} at #{Dir.pwd}.
        To get started, run the command

            #{command}

        and visit localhost:4567 in your browser.

      SAY
    end

  end

end
