require "fileutils"

module SinatraCli
  RSpec.describe Generators::RSpec do

    subject { Generators::RSpec.new(cli: Generate.new, app_path: "tmp") }

    around(:each) { |example| clear_temp_files &example }
    around(:each) { |example| suppress_output &example }

    describe "#generate" do

      before :each do
        FileUtils.copy "spec/fixtures/Gemfile", "tmp/Gemfile"
      end

      it "requires a Gemfile" do
        FileUtils.remove "tmp/Gemfile"
        expect { subject.generate }.to raise_error Thor::Error, "No Gemfile"
      end

      it "copies the RSpec template" do
        expect(subject).to generate_files.from_template(:rspec)
      end

      it "adds gems to the test group" do
        subject.generate
        gemfile = File.read "tmp/Gemfile"
        test_group = <<~GEMS
          group :test do
            gem "capybara", require: "capybara/rspec"
            gem "fuubar"
            gem "launchy"
            gem "rspec"
          end
        GEMS

        expect(gemfile).to include test_group
      end

      it "bundles the gems" do
        expect(subject).to generate_files "Gemfile.lock"
      end

      it "updates the readme" do
        FileUtils.copy "spec/fixtures/readme.md", "tmp/readme.md"

        readme = File.read "tmp/readme.md"
        original_section =
          readme.match(/(?<=<!-- testing -->\n).*(?=<!-- testing -->)/m).to_s

        subject.generate

        readme = File.read "tmp/readme.md"
        new_section =
          readme.match(/(?<=<!-- testing -->\n).*(?=<!-- testing -->)/m).to_s

        expect(readme).to include new_section
        expect(readme).not_to include original_section
      end

      it "returns self" do
        expect(subject.generate).to eq subject
      end
    end

  end
end
