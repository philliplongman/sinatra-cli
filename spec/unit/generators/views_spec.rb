module SinatraCli
  RSpec.describe Generators::Views do

    let(:subject) { Generators::Views.new(cli: cli, app_path: "tmp") }
    let(:cli)     { Generate.new([], { quiet: true }) }

    around(:each) { |example| clear_temp_files &example }

    describe "#generate" do
      it "copies the ERB views template" do
        expect(subject).to generate_files.from_template(:erb_views).in("app")
      end

      it "can generate Haml or Slim views instead of ERB" do
        haml_cli = Generate.new([], { haml: "", quiet: true })
        slim_cli = Generate.new([], { slim: "", quiet: true })

        subject.cli = haml_cli
        expect(subject).to generate_files.from_template(:haml_views).in("app")

        clear_temp_files

        subject.cli = slim_cli
        subject.generate
        expect(subject).to generate_files.from_template(:slim_views).in("app")
      end

      it "returns self" do
        expect(subject.generate).to eq subject
      end
    end

  end
end
