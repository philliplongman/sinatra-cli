module SinatraCli
  module Generators
    module Generatable
      extend ActiveSupport::Concern

      included do
        def underscored_name
          @underscored_name ||= app_path_name.underscore
        end

        def camelized_name
          @camelized_name ||= underscored_name.camelize
        end

        def app_path_name
          @app_path_name ||= File.basename app_path
        end

        def view_language
          return "haml" if cli.options.key? :haml
          return "slim" if cli.options.key? :slim
          "erb"
        end

        def copy_templates(from: self.class.name.demodulize.underscore, to: ".")
          cli.directory from, to, config
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
end
