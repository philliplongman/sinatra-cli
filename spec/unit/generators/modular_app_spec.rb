module SinatraCli
  RSpec.describe Generators::ModularApp do

    let(:subject) { Generators::ModularApp.new(cli: cli, app_path: "tmp") }
    let(:cli)     { Generate.new([], { quiet: true }) }

    around(:each) { |example| clear_temp_files! &example }

    describe "#generate" do
      it "copies the modular app template" do
        subject.generate
        expect("tmp").to have_files.from_template :modular_app
      end

      it "adds the gem for the view language" do
        haml_cli = Generate.new([], { haml: "", quiet: true })
        slim_cli = Generate.new([], { slim: "", quiet: true })

        subject.cli = haml_cli
        subject.generate
        expect(gemfile).to include %(gem "haml")

        clear_temp_files!

        subject.cli = slim_cli
        subject.generate
        expect(gemfile).to include %(gem "slim")
      end

      it "generates views" do
        views = generator_spy :views
        allow(Generators::Views).to receive(:new) { views }

        subject.generate

        expect(views).to have_received(:generate)
      end

      it "bundles the gems" do
        subject.generate
        expect("tmp").to have_files "Gemfile.lock"
      end

      it "returns self" do
        expect(subject.generate).to eq subject
      end
    end

  end
end
