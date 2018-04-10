module SinatraCli
  RSpec.describe Generators::Views do

    subject { Generators::Views.new(cli: Generate.new, app_path: "tmp") }

    around(:each) { |example| clear_temp_files &example }
    around(:each) { |example| suppress_output &example }

    describe "#generate" do
      it "copies the ERB views template" do
        expect(subject).to generate_files.from_template(:erb_views).in("app")
      end

      it "can generate Haml views instead of ERB" do
        cli = Generate.new([], { haml: "" })
        subject = Generators::Views.new(cli: cli, app_path: "tmp")

        expect(subject).to generate_files.from_template(:haml_views).in("app")
      end

      it "can generate Slim views instead of ERB" do
        cli = Generate.new([], { slim: "" })
        subject = Generators::Views.new(cli: cli, app_path: "tmp")

        expect(subject).to generate_files.from_template(:slim_views).in("app")
      end

      it "returns self" do
        expect(subject.generate).to eq subject
      end
    end

  end
end
