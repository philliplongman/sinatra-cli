module SinatraCli
  RSpec.describe Main do

    subject { Main.new }

    describe "#help" do
      it "outputs commands in custom order" do
        expected = command_order %w[new generate server test]

        expect { subject.help }.to output(expected).to_stdout
      end
    end

    describe "#new" do
      let(:generator) { generator_spy :project }

      it "generates a project" do
        suppress_output do
          subject.new("new_project", generator: generator)
          expect(generator).to have_received :generate
        end
      end

      it "prints instructions" do
        expect { subject.new("new_project", generator: generator) }.to output(/Success!/).to_stdout
      end
    end

    describe "#generate" do
      it "connects to the generate subcommand" do
        # Search help output for "rspec generate," not "sinatra generate,"
        # because Thor's help output is based on the file that started the
        # proceess.
        expect { subject.generate }
          .to output(/(Commands:)(\s+)(rspec generate)/).to_stdout
      end
    end

    describe "#server" do
      it "starts the server" do
        allow(File).to receive(:exist?).and_return(true)
        expect(subject).to receive(:exec).with(/bundle exec rerun puma/)
        subject.server
      end

      it "can start the server without rerun" do
        subject = Main.new([], { no_reload: nil })
        allow(File).to receive(:exist?).and_return(true)
        expect(subject).to receive(:exec).with(/bundle exec puma/)
        subject.server
      end

      it "raises an error if there's no config.ru" do
        expect { subject.server }.to raise_error("No config.ru file")
      end
    end

    describe "#test" do
      it "starts the test suite" do
        expect(subject).to receive(:exec).with(/bundle exec rspec/)
        subject.test
      end
    end

  end
end
