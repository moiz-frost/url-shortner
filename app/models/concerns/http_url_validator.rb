class HttpUrlValidator < ActiveModel::EachValidator
  def valid_url?(value)
    parsed = Addressable::URI.parse(value)
    uri = URI.parse(parsed.origin)
    uri.is_a?(URI::HTTP) && !uri.host.nil?
  rescue Addressable::URI::InvalidURIError, URI::InvalidURIError
    false
  end

  def validate_each(record, attribute, value)
    record.errors.add(attribute, 'is not a valid URL') unless value.present? && valid_url?(value)
  end
end
