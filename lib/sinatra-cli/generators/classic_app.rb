module SinatraCli::Generators
  class ClassicApp

    attr_reader :thor

    def initialize(thor)
      @thor = thor
    end

    def generate
      copy_templates
      self
    end

    def config
      { name: camelized_name }
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
      templates = Dir.glob("**/*", base: template_folder).reject do |name|
        File.directory? File.join(template_folder, name)
      end

      new_names = templates.map do |name|
        name.remove(".tt").gsub("newproject", underscored_name)
      end

      templates.zip(new_names).to_h
    end

    def template_folder
      File.join thor.templates_folder, self.class.name.demodulize.underscore
    end

  end
end
