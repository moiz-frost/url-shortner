class ApiKey < ApplicationRecord
  default_scope { where(is_deleted: false, deleted_at: nil) }

  belongs_to :user

  validates :user, presence: true
  validates :key, frozen: true

  before_save :ensure_api_key

  def deactivate
    update!(is_active: false)
  end

  def activate
    update!(is_active: true)
  end

  def toggle!
    update!(is_active: !is_active)
  end

  def destroy
    update!(is_deleted: true, deleted_at: Time.current)
  end

  private

  def generate_api_key
    loop do
      key = Devise.friendly_token 40
      break "tkn_#{key}" unless ApiKey.exists?(key: key)
    end
  end

  def ensure_api_key
    self.key ||= generate_api_key
  end
end
