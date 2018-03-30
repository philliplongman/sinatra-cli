module SinatraCli::Generators
  module Templatable
    extend ActiveSupport::Concern

    included do
      private

      def copy_templates_to(destination_dir, **config)
        templates.each do |src, dst|
          cli.template("#{template_dir}/#{src}", "#{destination_dir}/#{dst}", config)
        end
      end

      def templates
        glob = Dir.glob("**/*", File::FNM_DOTMATCH, base: template_dir)

        template_files = glob.reject do |name|
          File.directory? File.join(template_dir, name)
        end

        destinations = template_files.map do |name|
          name.remove(".tt").gsub("projectname", underscored_name)
        end

        template_files.zip(destinations).to_h
      end

      def template_dir
        @template_dir ||=
          File.join cli.templates_folder, self.class.name.demodulize.underscore
      end
    end

  end
end
