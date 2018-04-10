module SinatraCli
  RSpec.describe Generators::ClassicApp do

    subject { Generators::ClassicApp.new(cli: Generate.new, app_path: "tmp") }

    around(:each) { |example| clear_temp_files &example }
    around(:each) { |example| suppress_output &example }

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
