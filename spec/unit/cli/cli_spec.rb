module SinatraCli
  RSpec.describe Cli do

    subject { Cli.new }

    describe "::help" do
      it "replaces the output for the help command" do
        help_output = /Run commands with -h or --help for more information./

        expect { Cli.help(subject) }.to output(help_output).to_stdout
      end
    end

    describe "#which" do
      it "returns the path of the given executable" do
        expect(subject.which "git").to_not be nil
      end

      it "returns nil if the executable is not found" do
        expect(subject.which "non_existant_executable").to be nil
      end
    end

  end
end
