module SinatraCli
  RSpec.describe Generators::GitRepo do

    subject { Generators::GitRepo.new(cli: Generate.new, app_path: "tmp") }

    around(:each) { |example| clear_temp_files &example }
    around(:each) { |example| suppress_output &example }

    describe "#generate" do
      it "creates a git repo" do
        git_files = %w[.git/HEAD .git/config .git/description]
        subject.generate
        expect(generator_output).to include *git_files
      end
    end

  end
end
