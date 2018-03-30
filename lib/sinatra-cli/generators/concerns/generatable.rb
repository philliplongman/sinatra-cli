module SinatraCli::Generators
  module Generatable
    extend ActiveSupport::Concern

    included do
      def path_name
        File.basename(app_path)
      end

      def underscored_name
        @underscored_name ||= path_name.underscore
      end

      def camelized_name
        @camelized_name ||= underscored_name.camelize
      end
    end

  end
end
