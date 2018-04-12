module SinatraCli
  RSpec.describe Generators::Project do

    let(:subject) { Generators::Project.new(cli: cli, app_path: "tmp") }
    let(:cli)     { Main.new([], { quiet: true }) }

    around(:each) { |example| clear_temp_files! &example }

    describe "#generate" do
      it "creates a project in the specified folder" do
        subject.generate
        expect("tmp").to have_files.from_template :modular_app

        clear_temp_files!

        subject.app_path = "tmp/new_project"
        subject.generate
        expect("tmp").not_to have_files.from_template :modular_app
        expect("tmp/new_project").to have_files.from_template :modular_app
      end

      it "runs multiple generators to create a project" do
        modular_app = generator_spy :modular_app
        allow(Generators::ModularApp).to receive(:new) { modular_app }

        views = generator_spy :views
        allow(Generators::Views).to receive(:new) { views }

        git_repo = generator_spy :git_repo
        allow(Generators::GitRepo).to receive(:new) { git_repo }

        rspec = generator_spy :rspec
        allow(Generators::RSpec).to receive(:new) { rspec }

        subject.generate

        expect(modular_app).to have_received :generate
        expect(git_repo).to have_received :generate
        expect(rspec).to have_received :generate
      end

      it "does not run skipped generators" do
        cli = Main.new([], { skip_test: true, quiet: true })
        subject.cli = cli
        subject.generate

        expect("tmp").not_to have_files.from_template :rspec
      end

      it "returns self" do
        expect(subject.generate).to eq subject
      end
    end

  end
end
