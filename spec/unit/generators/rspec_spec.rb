require "fileutils"

module SinatraCli
  RSpec.describe Generators::RSpec do

    let(:subject) { Generators::RSpec.new(cli: cli, app_path: "tmp") }
    let(:cli)     { Generate.new([], { quiet: true }) }

    around(:each) { |example| clear_temp_files! &example }

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

        testing_tags = /(?<=<!-- testing -->\n).*(?=<!-- testing -->)/m

        original_readme = File.read "tmp/readme.md"
        original_section = original_readme.match(testing_tags).to_s

        subject.generate

        updated_readme = File.read "tmp/readme.md"
        new_section = updated_readme.match(testing_tags).to_s

        expect(updated_readme).not_to eq original_readme
        expect(updated_readme).to include new_section
        expect(updated_readme).not_to include original_section
      end

      it "returns self" do
        expect(subject.generate).to eq subject
      end
    end

  end
end
