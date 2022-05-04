module Decodable
  extend ActiveSupport::Concern

  class_methods do
    def decodes(*attributes)
      attributes.each do |attribute|
        define_method("decoded_#{attribute}".to_sym) do |value|
          if respond_to?(attribute.to_s)
            return unless value.present?

            Service::Url.decode value
          else
            super(value)
          end
        end
      end
    end
  end
end
