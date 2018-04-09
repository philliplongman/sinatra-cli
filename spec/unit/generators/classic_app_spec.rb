module SinatraCli
  RSpec.describe Generators::ClassicApp do

    subject { Generators::ClassicApp.new(cli: Generate.new, app_path: "tmp") }

    around(:each) { |example| clear_temp_files &example }
    around(:each) { |example| suppress_output &example }

    describe "#generate" do
      it "copies the classic app template" do
        subject.generate
        expect(generator_output).to match_template :classic_app
      end
    end

  end
end
