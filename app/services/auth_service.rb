class AuthService
  def self.auth_session=(auth_session)
    @auth_session = auth_session
  end

  def self.auth_session
    @auth_session
  end

  def self.current_user
    @auth_session&.user
  end

  def self.authenticated?
    @auth_session&.active?
  end
end
