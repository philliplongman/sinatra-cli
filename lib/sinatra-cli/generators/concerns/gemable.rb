require "active_support/concern"

module SinatraCli
  module Generators
    module Gemable
      extend ActiveSupport::Concern
      # -------------------------------------
      # Methods for interacting with Gemfiles
      # -------------------------------------
      included do
        private

        # Relative path to the Gemfile in the app
        #
        def gemfile
          "#{app_path}/Gemfile"
        end

        # Raise an error if there is no Gemfile, before trying to
        # interact with it.
        #
        def check_for_gemfile
          raise Thor::Error, "No Gemfile" unless File.exist?(gemfile)
        end

        # Add gem(s) to the appropriate spot in the Gemfile. For simplicity,
        # it currently accepts a plain text code that will be inserted
        # directly into the Gemfile. This is much simpler than trying to
        # convert Ruby code into plain text.
        #
        def add_gems(gems_code, group: nil)
          check_for_gemfile

          # ensure a newline at the end
          gems_code = gems_code.chomp << "\n"

          if group
            add_to_group(group, gems_code)
          else
            add_to_default(gems_code)
          end
        end

        # Add text at the bottom of the default group
        #
        def add_to_default(gems_code)
          # starting the the top with "source", find the very last line
          # in the default group, before the gem "group"
          pattern = /(?:source).+?(?=\ngroup)/m

          cli.insert_into_file(gemfile, gems_code, after: pattern)
        end

        # Add text to the bottom of the gem group
        #
        def add_to_group(group, gems_code)
          # convert group to string formatted like `:development, :test`
          group_top = Array(group).join(", ").gsub(/\b(?=\w)/, ":")
          # find top of block under `group .. do` and `end`
          pattern = "group #{group_top} do\n"

          # add padding to text
          gems_code.gsub!(/^/, "  ")

          cli.insert_into_file(gemfile, gems_code, after: pattern)
        end

        # Run `bundle install` with the Gemfile for the project
        #
        def bundle_gems
          check_for_gemfile
          cli.run "BUNDLE_GEMFILE=#{gemfile} bundle install"
        end
      end

    end
  end
end
