module SinatraCli
  RSpec.describe Generators::ClassicApp do

    subject { Generators::ClassicApp.new(cli: Generate.new, app_path: "tmp") }

    around :each, :clear_temp_files

    describe "#generate" do
      it "creates a classic app"
    end

  end
end
