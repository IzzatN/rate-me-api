class AuthSessionsController < ApplicationController
  skip_before_action :authenticate

  def create
    email = params[:data][:attributes][:email]&.downcase
    password = params[:data][:attributes][:password]

    user = User.find_by(email: email, is_registered: true)

    unless user.try(:authenticate, password)
      data = { errors: [{ status: 401, code: 'Unauthorized', detail: 'Email or password are incorrect' }] }
      return render json: data, status: :unauthorized
    end

    # unless user.confirmed_at?
    #   data = { errors: [{ status: 401, code: 'Unauthorized', detail: 'Please confirm your email address before logging in.' }] }
    #   return render json: data, status: :unauthorized
    # end

    # if user.is_inactive?
    #   text = "Failed sign-in attempt as inactive user #{user.first_name} #{user.last_name} (#{user.email})."

    #   data = { errors: [{ status: 401, code: 'Unauthorized', detail: 'Account is inactive' }] }

    #   return render json: data, status: :unauthorized
    # end

    auth_session = user.auth_sessions.create(expires_at: 3.months.from_now)

    render json: AuthSessionSerializer.new(auth_session, include: [:user, :"user.company"]).serializable_hash
  end

  def index
    if request.params[:token].blank?
      return head :forbidden
    end

    auth_sessions = AuthSession.active.where(token: request.params[:token])

    render json: AuthSessionSerializer.new(auth_sessions,
      include: [
        :user,
        :'user.company'
      ]
    ).serializable_hash
  end
end
