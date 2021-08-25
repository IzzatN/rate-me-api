class AuthSession < ApplicationRecord
  TOKEN_LENGTH = 16

  belongs_to :user

  before_create :set_token
  before_create :set_expires_at

  scope :active, -> { where('expires_at > ?', Time.now) }
  scope :expired, -> { where('expires_at <= ?', Time.now) }

  def active?
    expires_at > Time.now
  end

  private

  def set_token
    while token.blank? || self.class.where(token: token).count > 0
      self.token = SecureRandom.hex(TOKEN_LENGTH)
    end
  end

  def set_expires_at
    self.expires_at ||= 3.months.from_now
  end
end
