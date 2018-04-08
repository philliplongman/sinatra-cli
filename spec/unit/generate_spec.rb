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
      before :each do
        stub_generator(:modular_app)
      end

      it "generates a modular-style app" do
        suppress_output do
          expect_any_instance_of(Generators::ModularApp).to receive(:generate)

          subject.modular
        end
      end

      it "prints instructions" do
        expect { subject.modular }.to output(/Success!/).to_stdout
      end
    end

    describe "#classic" do
      before :each do
        stub_generator(:classic_app)
      end

      it "generates a classic-style app" do
        suppress_output do
          expect_any_instance_of(Generators::ClassicApp).to receive(:generate)

          subject.classic
        end
      end

      it "prints instructions" do
        expect { subject.classic }.to output(/Success!/).to_stdout
      end
    end

    describe "#tests" do
      before :each do
        stub_generator(:rspec)
      end

      it "generates an RSpec installation" do
        suppress_output do
          expect_any_instance_of(Generators::RSpec).to receive(:generate)

          subject.tests
        end
      end

      it "prints instructions" do
        expect { subject.tests }.to output(/Success!/).to_stdout
      end
    end

  end
end
