require "active_support/concern"
require "active_support/core_ext/string/filters"
require "active_support/core_ext/string/inflections"

module SinatraCli
  module Generators
    module Templatable
      extend ActiveSupport::Concern
      # ----------------------------------------
      # Methods for dealing with templates files
      # ----------------------------------------
      included do
        # Return snake-case name of app.
        #
        def underscored_name
          @underscored_name ||= app_path_basename.underscore
        end

        # Return camel-case name of app. Must go through snake case first,
        # to handle hyphens properly.
        #
        def camelized_name
          @camelized_name ||= underscored_name.camelize
        end

        # Return name of created folder, or current folder if "." was
        # specified as app_path.
        #
        def app_path_basename
          @app_path_basename ||= File.basename app_path
        end

        # Return absolute path of app_path
        #
        def absolute_app_path
          File.absolute_path app_path
        end

        private

        # Return snake-case name of current class, with namespaces removed.
        #
        def generator_name
          @generator_name ||= self.class.name.demodulize.underscore
        end

        # Return template language to use for views. Default ERB.
        #
        def view_language
          return "haml" if cli.options.key? :haml
          return "slim" if cli.options.key? :slim
          "erb"
        end

        # Use Thor's directory method to copy files from template folder
        # to app path. Files ending in `.tt` are treated as templates.
        # They use ERB tags to dynamically process Ruby code. Variables
        # can be passed to them through the `config` hash.
        #
        def copy_templates(from: generator_name, to: app_path)
          cli.directory from, to, template_variables
        end

        # Return an empty hash unless overwritten in the class.
        #
        def template_variables
          {}
        end

        # Look for section in the readme between two HTML comment tags and
        # replace it with given text.
        #
        def replace_readme_section(section, with_text:)
          cli.gsub_file readme, match_readme_section(section), with_text
        end

        # Return regex to match text between to HTML comments of given string.
        # Example:
        #   <!-- testing -->REGEX MATCH<!-- testing -->
        #
        def match_readme_section(section)
          /(?<=<!-- #{section} -->\n).*(?=<!-- #{section} -->)/m
        end

        # Relative path to readme file for the generated app.
        #
        def readme
          "#{app_path}/readme.md"
        end
      end

    end
  end
end
