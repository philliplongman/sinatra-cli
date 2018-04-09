require "ostruct"

module SinatraCli
  RSpec.describe Generators::Templatable do

    class DummyGenerator < OpenStruct
      include Generators::Templatable
    end

    let(:here)  { DummyGenerator.new(app_path: ".") }
    let(:there) { DummyGenerator.new(app_path: "amazing_project") }

    describe "#underscored_name" do
      it "returns the app name in snake case" do
        expect(here.underscored_name).to eq "sinatra_cli"
        expect(there.underscored_name).to eq "amazing_project"
      end
    end

    describe "#camelized_name" do
      it "returns the app name in camel case" do
        expect(here.camelized_name).to eq "SinatraCli"
        expect(there.camelized_name).to eq "AmazingProject"
      end
    end

    describe "#app_path_basename" do
      it "returns the name of the directory the generator is working in" do
        expect(here.app_path_basename).to eq "sinatra-cli"
        expect(there.app_path_basename).to eq "amazing_project"
      end
    end

    describe "#absolute_app_path" do
      it "returns the absolute path to the directory the generator is working in" do
        expect(here.absolute_app_path).to eq File.absolute_path "."
        expect(there.absolute_app_path).to eq File.absolute_path "amazing_project"
      end
    end

  end
end
