require 'addressable/uri'

class Service::Url
  class << self
    def decode(encoded_url)
      decoded_url = encoded_url
      loop do
        decoded_url = Addressable::URI.unencode(decoded_url)
        break unless decoded_url != Addressable::URI.unencode(decoded_url)
      end
      decoded_url
    end

    def encode(decoded_url)
      Addressable::URI.encode(decoded_url)
    end
  end
end
