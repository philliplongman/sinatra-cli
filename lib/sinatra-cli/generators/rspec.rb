module SinatraCli
  module Generators
    class RSpec
      include Generatable
      include Gemable

      attr_reader :cli, :app_path, :template_name

      def initialize(cli:, app_path: Dir.pwd, tests_path: "spec")
        @cli = cli
        @app_path = app_path
        @template_name = "rspec"
        destination_root = app_path
      end

      def config
        { app_name: camelized_name }
      end

      def generate
        copy_templates from: template_name
        add_gems test_gems, group: :test
        bundle_gems
        replace_readme_section :testing, with_text: readme_text
        self
      end

      private

      def test_gems
        <<~GEMS
          gem "capybara", require: "capybara/rspec"
          gem "fuubar"
          gem "launchy"
          gem "rspec"
        GEMS
      end

      def readme_text
        <<~README
          RSpec and Capybara are installed for testing. Write your tests in the `spec` directory and end the filenames with `_spec`. To run your tests, use the command
          ```
          $ rspec
          ```
          You can write helper methods in `spec/support/test_helper.rb`, and your tests will automatically have access to them.
        README
      end

    end
  end
end
