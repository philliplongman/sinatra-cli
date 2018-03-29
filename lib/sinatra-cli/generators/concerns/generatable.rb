module SinatraCli::Generators
  module Generatable
    extend ActiveSupport::Concern

    included do
      attr_reader :thor

      def initialize(thor)
        @thor = thor
      end

      def camelized_name
        @camelized_name ||= underscored_name.camelize
      end

      def underscored_name
        @underscored_name ||= File.basename(Dir.pwd).underscore
      end

      private

      def copy_templates
        templates.each do |src, dst|
          thor.template("#{template_folder}/#{src}", "#{Dir.pwd}/#{dst}", config)
        end
      end

      def templates
        glob = Dir.glob("**/*", File::FNM_DOTMATCH, base: template_folder)

        template_files = glob.reject do |name|
          File.directory? File.join(template_folder, name)
        end

        destinations = template_files.map do |name|
          name.remove(".tt").gsub("projectname", underscored_name)
        end

        template_files.zip(destinations).to_h
      end

      def template_folder
        File.join thor.templates_folder, self.class.name.demodulize.underscore
      end

      def bundle_gems
        gemfile = "BUNDLE_GEMFILE=#{Dir.pwd}/Gemfile"
        thor.run "#{gemfile} bundler install"
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
