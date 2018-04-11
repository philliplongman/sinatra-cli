module SinatraCli
  RSpec.describe Main do

    let(:subject) { Main.new([], { quiet: true }) }
    let(:noisy_subject) { Main.new }

    describe "#help" do
      it "outputs commands in custom order" do
        expected = command_order %w[new generate server test]

        expect { noisy_subject.help }.to output(expected).to_stdout
      end
    end

    describe "#new" do
      let(:generator) { generator_spy :project }

      it "generates a project" do
        subject.new("new_project", generator: generator)
        expect(generator).to have_received :generate
      end

      it "prints instructions" do
        expect { noisy_subject.new("new_project", generator: generator) }.to output(/Success!/).to_stdout
      end
    end

    describe "#generate" do
      it "connects to the generate subcommand" do
        # Search help output for "rspec generate," not "sinatra generate,"
        # because Thor's help output is based on the file that started the
        # proceess.
        expect { noisy_subject.generate }
          .to output(/(Commands:)(\s+)(rspec generate)/).to_stdout
      end
    end

    describe "#server" do
      it "starts the server" do
        allow(File).to receive(:exist?).with("config.ru") { true }
        allow(subject).to receive(:exec)

        subject.server

        expect(subject).to have_received(:exec).with(/bundle exec rerun puma/)
      end

      it "can start the server without rerun" do
        subject = Main.new([], { no_reload: nil, quiet: true })
        allow(File).to receive(:exist?).with("config.ru") { true }
        allow(subject).to receive(:exec)

        subject.server

        expect(subject).to have_received(:exec).with(/bundle exec puma/)

      end

      it "raises an error if there's no config.ru" do
        expect { noisy_subject.server }.to raise_error("No config.ru file")
      end
    end

    describe "#test" do
      it "starts the test suite" do
        allow(subject).to receive(:exec)
        
        subject.test

        expect(subject).to have_received(:exec).with(/bundle exec rspec/)
      end
    end

  end
end
