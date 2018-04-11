module SinatraCli
  RSpec.describe Generators::ModularApp do

    let(:subject) { Generators::ModularApp.new(cli: cli, app_path: "tmp") }
    let(:cli)     { Generate.new([], { quiet: true }) }

    around(:each) { |example| clear_temp_files &example }

    describe "#generate" do
      it "copies the modular app template" do
        expect(subject).to generate_files.from_template :modular_app
      end

      it "adds the gem for the view language" do
        haml_cli = Generate.new([], { haml: "", quiet: true })
        slim_cli = Generate.new([], { slim: "", quiet: true })

        subject.cli = haml_cli
        subject.generate
        expect(gemfile).to include %(gem "haml")

        clear_temp_files

        subject.cli = slim_cli
        subject.generate
        expect(gemfile).to include %(gem "slim")
      end

      it "generates views" do
        view_generator = instance_double("Generators::Views")
        expect(view_generator).to receive(:generate)
        allow(Generators::Views).to receive(:new) { view_generator }

        subject.generate
      end

      it "bundles the gems" do
        expect(subject).to generate_files "Gemfile.lock"
      end

      it "returns self" do
        expect(subject.generate).to eq subject
      end
    end

  end
end
