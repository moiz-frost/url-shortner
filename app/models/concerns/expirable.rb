module Expirable
  extend ActiveSupport::Concern

  included do
    def expire!
      return unless expired?

      update!(expires_at: Time.current)
    end

    def expired?
      expires_at > Time.current
    end
  end
end
