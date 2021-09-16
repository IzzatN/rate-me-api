class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  prepend_before_action :load_current_user
  prepend_before_action :authenticate

  include Pagy::Backend

  protected

  def current_user
    @auth_session.try(:user)
  end

  private

  def authenticate
    unless load_current_user
      data = { errors: [status: 401, code: 'Unauthorized', detail: 'Unauthenticated request'] }
      return render json: data, status: :unauthorized
    end
  end

  def load_current_user
    auth = request.headers['Authorization']

    unless auth.blank?
      token = auth[/Bearer (.*)/, 1]
      @auth_session = AuthSession.active.find_by(token: token)
      AuthService.auth_session = @auth_session

      @auth_session
    end
  end
end
