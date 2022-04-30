require 'resolv'

class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, 'is invalid') if value !~ Regex::EMAIL_REGEX
  end
end
