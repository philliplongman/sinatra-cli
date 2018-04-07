module SinatraCli
  RSpec.describe Cli do

    describe "::help" do
      it "replaces the output for the help command" do
        instance = Cli.new
        help_output = /Run commands with -h or --help for more information./

        expect { Cli.help(instance) }.to output(help_output).to_stdout
      end
    end

    describe "#which" do
      it "returns the path of the given executable" do
        expect(Cli.new.which "git").to_not be nil
      end

      it "returns nil if the executable is not found" do
        expect(Cli.new.which "non_existant_executable").to be nil
      end
    end

  end
end
