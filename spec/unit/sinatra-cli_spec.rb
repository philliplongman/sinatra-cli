RSpec.describe SinatraCli do
  it "has a version number" do
    expect(SinatraCli::VERSION).not_to be nil
  end

  describe "::root" do
    it "returns the root sinatra-cli dir" do
      expect(SinatraCli.root) == SinatraCli::ROOT
      expect(SinatraCli.root) == File.expand_path(__dir__, "../lib/sinatra-cli")
    end
  end
end
