module SinatraCli
  RSpec.describe Generators::GitRepo do

    let(:subject) { Generators::GitRepo.new(cli: cli, app_path: "tmp") }
    let(:cli)     { Generate.new([], { quiet: true }) }

    around(:each) { |example| clear_temp_files! &example }

    describe "#generate" do
      it "creates a git repo" do
        expect(subject).to generate_files ".git"
      end

      it "doesn't run if git isn't present" do
        cli = instance_double("Generate")
        allow(cli).to receive(:which).and_return(nil)
        subject = Generators::GitRepo.new(cli: cli, app_path: "tmp")

        expect(subject).not_to generate_files ".git"
      end
    end

  end
end
