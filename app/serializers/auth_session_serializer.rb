class AuthSessionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :token, :expires_at

  belongs_to :user
end
