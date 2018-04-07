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
      before :each do
        stub_generator(:project)
      end

      it "generates a project" do
        suppress_output do
          expect_any_instance_of(Generators::Project).to receive(:generate)

          subject.new("new_project")
        end
      end

      it "prints instructions" do
        expect { subject.new("new_project") }.to output(/sinatra server/).to_stdout
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
