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
      end


    end

  end
end
