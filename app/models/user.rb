class User < ApplicationRecord
  TOKEN_LENGTH = 16

  auto_strip_attributes :first_name, :last_name, :email
  has_secure_password

  has_many :comments, dependent: :destroy
  has_many :companies, dependent: :destroy
  has_many :auth_sessions, dependent: :destroy
  has_many :ranks, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :first_name, :last_name, presence: true

  before_create :set_token
  before_create :set_uuid
  after_update :set_token

  def set_uuid
    self.uuid = SecureRandom.uuid
  end

  def set_token
    while token.blank? || self.class.where.not(id: id).where(token: token).exists?
      self.token = SecureRandom.hex(TOKEN_LENGTH)
    end
  end
end
