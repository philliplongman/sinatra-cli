module SinatraCli
  RSpec.describe Generators::ClassicApp do

    let(:subject) { Generators::ClassicApp.new(cli: cli, app_path: "tmp") }
    let(:cli)     { Generate.new([], { quiet: true }) }

    around(:each) { |example| clear_temp_files! &example }

    describe "#generate" do
      it "copies the classic app template" do
        expect(subject).to generate_files.from_template :classic_app
      end

      it "returns self" do
        expect(subject.generate).to eq subject
      end
    end

  end
end
