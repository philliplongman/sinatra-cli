require_rel "cli"

module SinatraCli
  class Main < Cli
    # -----------------------------------------------
    # Class for the lowest level of the CLI interface
    # -----------------------------------------------

    class << self
      protected

      # Define order list of commands will be printed by the help command.
      # Returns a proc which will be fed to #sort_by!
      #
      def custom_order
        return proc do |command_output|
          case command_output.first
          when /new/      then 1
          when /generate/ then 2
          when /server/   then 3
          when /test/     then 4
          else                 5
          end
        end
      end
    end

  end
end
