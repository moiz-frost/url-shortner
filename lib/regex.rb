class Regex
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i.freeze
  BASE62_UNIQUE_CHARACTERS_REGEX = /(?:([0-9a-zA-Z])(?!.*\1)){1,62}/.freeze
end
