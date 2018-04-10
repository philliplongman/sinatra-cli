module SinatraCli
  RSpec.describe Generators::ModularApp do

    subject { Generators::ModularApp.new(cli: Generate.new, app_path: "tmp") }

    around(:each) { |example| clear_temp_files &example }
    around(:each) { |example| suppress_output &example }

    describe "#generate" do
      it "copies the modular app template" do
        expect(subject).to generate_files.from_template :modular_app
      end

      it "adds the gem for the view language" do
        cli = Generate.new([], { slim: "" })
        Generators::ModularApp.new(cli: cli, app_path: "tmp").generate
        expect(gemfile).to include %(gem "slim")

        clear_temp_files

        cli = Generate.new([], { haml: "" })
        Generators::ModularApp.new(cli: cli, app_path: "tmp").generate
        expect(gemfile).to include %(gem "haml")
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
