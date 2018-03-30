module SinatraCli::Generators
  module Generatable
    extend ActiveSupport::Concern

    included do
      def camelized_name
        @camelized_name ||= underscored_name.camelize
      end

      def underscored_name
        @underscored_name ||= File.basename(app_path).underscore
      end

      private

      def bundle_gems
        gemfile = "BUNDLE_GEMFILE=#{Dir.pwd}/Gemfile"
        cli.run "#{gemfile} bundler install"
      end

      # Stolen from Bundler
      def which(executable)
        if File.file?(executable) && File.executable?(executable)
          executable
        elsif paths = ENV["PATH"]
          quote = '"'.freeze
          paths.split(File::PATH_SEPARATOR).find do |path|
            path = path[1..-2] if path.start_with?(quote) && path.end_with?(quote)
            executable_path = File.expand_path(executable, path)
            return executable_path if File.file?(executable_path) && File.executable?(executable_path)
          end
        end
      end
    end

  end
end
