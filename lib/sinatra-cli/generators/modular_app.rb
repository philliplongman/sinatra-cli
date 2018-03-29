module SinatraCli::Generators
  class ModularApp
    include Generatable

    def config
      { app_name: camelized_name }
    end

    def generate
      copy_templates
      bundle_gems
      self
    end

  end
end
