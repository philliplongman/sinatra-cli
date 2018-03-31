module SinatraCli::Commands::Generate
  extend ActiveSupport::Concern

  included do
    desc "generate ELEMENT", "Run generator to add ELEMENT to project"
    subcommand "generate", Command
  end

  class Command < Thor
    include Thor::Actions
    include SinatraCli::Generators

    # MODULAR ------------------------------------------------------------------
    desc "modular [options]", "Generate a modular-style Sinatra app"

    option :erb,  hide: true
    option :haml, banner: "", desc: "Use Haml for views, instead of ERB."
    option :slim, banner: "", desc: "Use Slim for views, instead of ERB."

    def modular
      app = ModularApp.new(cli: self).generate
      command = set_color("sinatra server", :cyan)
      say <<~SAY

        Success! Created #{app.camelized_name} at #{Dir.pwd}.
        To get started, use the command

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
        To get started, use the command

            #{command}

        and visit localhost:4567 in your browser.

      SAY
    end

    # RSpec --------------------------------------------------------------------
    desc "rspec", "Generate an RSpec installation"

    def rspec
      app = RSpec.new(cli: self).generate
      command = set_color("rspec", :cyan)
      say <<~SAY

        Success! RSpec and Capybara have been installed. Put your tests in #{app.underscored_name}/spec/
        To run your them, use the command

            #{command}

      SAY
    end

    # Internal methods ---------------------------------------------------------

    no_commands do
      def self.source_root
        File.expand_path "../templates", File.dirname(__FILE__)
      end

      def templates_folder
        self.class.source_root
      end

      def view_language
        @view_language ||= options[:haml] || options[:slim] || "erb"
      end
    end

  end

end
