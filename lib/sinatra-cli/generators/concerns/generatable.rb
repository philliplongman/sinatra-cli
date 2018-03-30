module SinatraCli::Generators
  module Generatable
    extend ActiveSupport::Concern

    included do
      def path_name
        File.basename(app_path)
      end

      def underscored_name
        @underscored_name ||= path_name.underscore
      end

      def camelized_name
        @camelized_name ||= underscored_name.camelize
      end

      def replace_readme_section(section, with_text:)
        cli.gsub_file readme, match_readme_section(section), with_text
      end

      def match_readme_section(section)
        /(?<=<!-- #{section} -->\n).*(?=<!-- #{section} -->)/m
      end

      def readme
        "#{app_path}/readme.md"
      end
    end

  end
end
