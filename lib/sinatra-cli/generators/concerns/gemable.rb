module SinatraCli::Generators
  module Gemable
    extend ActiveSupport::Concern

    included do
      private

      def gemfile
        "#{app_path}/Gemfile"
      end

      def gemfile_code(gem_hash, pad: false)
        String.new.tap do |text|
          gem_hash.each do |gem, options|
            text << "  " if pad
            text << %(gem "#{gem}")
            options&.each do |key, value|
              text << %(, #{key}: "#{value}")
            end
            text << "\n"
          end
        end
      end

      def add_gems_to_default(*gem_array, **gem_hash)
        gems = (gem_array.zip([]) + gem_hash.to_a).sort.to_h

        pattern = /(?:source).+?(?=\ngroup)/m

        cli.insert_into_file(
          gemfile,
          gemfile_code(gems),
          after: pattern
        )
      end

      def add_gems_to_group(group, *gem_array, **gem_hash)
        gems = (gem_array.zip([]) + gem_hash.to_a).sort.to_h

        group_string = Array(group).map { |e| ":#{e}" }.join(", ")
        pattern = "group #{group_string} do\n"

        cli.insert_into_file(
          gemfile,
          gemfile_code(gems, pad: true),
          after: pattern
        )
      end

      def bundle_gems
        cli.run "BUNDLE_GEMFILE=#{gemfile} bundle install"
      end

    end

  end
end
