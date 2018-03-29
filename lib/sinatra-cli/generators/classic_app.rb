module SinatraCli::Generators
  class ClassicApp
    include Generatable

    def config
      { app_name: camelized_name }
    end

    def generate
      copy_templates
      self
    end

  end
end
