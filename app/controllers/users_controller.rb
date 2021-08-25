class UsersController < ApplicationController
  skip_before_action :authenticate

  def index
    users = User.all

    render json: UserSerializer.new(users).serializable_hash
  end

  def show
    user = User.find(params[:id])

    if user
      render json: UserSerializer.new(user).serializable_hash
    else
      data = { errors: [status: 404, code: 'NotFound', detail: "Record not found"] }
      render json: data, status: :not_found
    end
  end

  def create
    user = User.new(create_params)

    if user.save
      render json: UserSerializer.new(user).serializable_hash
    else
      data = { errors: [status: 400, code: 'BadRequest', details: user.errors.messages] }
      render json: data, status: 400
    end
  end

  def update
    user = User.find_by(id: params[:id])

    unless user
      data = { errors: [status: 404, code: 'NotFound', detail: "Record not found"] }
      render json: data, status: :not_found
    end

    if user.update(update_params)
      render json: UserSerializer.new(user).serializable_hash
    else
      data = { errors: [ status: 422, code: 'UnprocessableEntity', detail: user.errors.messages ] }
      render json: data, status: :unprocessable_entity
    end
  end

  private

  def create_params
    user = params[:data].require(:attributes).permit(
      :email,
      :first_name,
      :last_name,
      :phone,
      :photo_url,
      :is_consumer
    )

    user
  end

  def update_params
    user = params[:data].require(:attributes).permit(
      :first_name,
      :last_name,
      :phone,
      :photo_url
    )

    user
  end
end
