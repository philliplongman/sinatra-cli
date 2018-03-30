module SinatraCli::Generators
  module Gemable
    extend ActiveSupport::Concern

    included do
      private

      def gemfile
        "#{app_path}/Gemfile"
      end

      def ensure_gemfile_exists
        raise Thor::Error, "No Gemfile" unless File.exist?(gemfile)
      end

      def add_gems(gems, group: nil)
        ensure_gemfile_exists

        # ensure newline
        gems = gems.chomp << "\n"

        if group
          group_str = Array(group).join(", ").gsub(/\b(?=\w)/, ":")
          pattern = "group #{group_str} do\n"
          gems.gsub!(/^/, "  ")
        else
          pattern = /(?:source).+?(?=\ngroup)/m
        end

        cli.insert_into_file(gemfile, gems, after: pattern)
      end

      def bundle_gems
        ensure_gemfile_exists
        cli.run "BUNDLE_GEMFILE=#{gemfile} bundle install"
      end

    end

  end
end
