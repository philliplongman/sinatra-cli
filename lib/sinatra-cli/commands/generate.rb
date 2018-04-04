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

    class << self
      protected

      # Define order list of commands will be printed by the help command.
      # Returns a proc which will be fed to #sort_by!
      #
      def custom_order
        return proc do |command_output|
          case command_output.first
          when /modular/  then 1
          when /classic/  then 2
          when /tests/    then 3
          else                 4
          end
        end
      end
    end

  end
end
