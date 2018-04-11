module SinatraCli
  RSpec.describe Generate do

    subject { Generate.new }

    describe "#help" do
      it "outputs commands in custom order" do
        expected = command_order %w[modular classic tests]

        expect { subject.help }.to output(expected).to_stdout
      end
    end

    describe "#modular" do
      let(:generator) { generator_spy :modular_app }

      it "generates a modular-style app" do
        suppress_output do
          subject.modular(generator: generator)
          expect(generator).to have_received :generate
        end
      end

      it "prints instructions" do
        expect { subject.modular(generator: generator) }.to output(/Success!/).to_stdout
      end
    end

    describe "#classic" do
      let(:generator) { generator_spy :classic_app }

      it "generates a classic-style app" do
        suppress_output do
          subject.classic(generator: generator)
          expect(generator).to have_received :generate
        end
      end

      it "prints instructions" do
        expect { subject.classic(generator: generator) }.to output(/Success!/).to_stdout
      end
    end

    describe "#tests" do
      let(:generator) { generator_spy :rspec }

      it "generates an RSpec installation" do
        suppress_output do
          subject.tests(generator: generator)
          expect(generator).to have_received :generate
        end
      end

      it "prints instructions" do
        expect { subject.tests(generator: generator) }.to output(/Success!/).to_stdout
      end
    end

  end
end
