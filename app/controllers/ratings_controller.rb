class RatingsController < ApplicationController
  skip_before_action :authenticate

  def show
    rating = Rating.find(params[:id])

    if rating
      render json: RatingSerializer.new(rating).serializable_hash
    else
      data = { errors: [status: 404, code: 'NotFound', detail: "Record not found"] }
      render json: data, status: :not_found
    end
  end

  def create
    rating = Rating.new(create_params)

    if rating.save
      render json: RatingSerializer.new(rating).serializable_hash
    else
      data = { errors: [status: 422, code: 'UnprocessableEntity', details: rating.errors.messages] }
      render json: data, status: :unprocessable_entity
    end
  end

  def update
    rating = Rating.find(params[:data][:id])

    if rating.update(update_params)
      render json: RatingSerializer.new(rating).serializable_hash
    else
      data = { errors: [status: 422, code: 'UnprocessableEntity', details: rating.errors.messages] }
      render json: data, status: :unprocessable_entity
    end
  end

  private

  def create_params
    rating = params[:data].require(:attributes).permit(
      :rating
    )

    if data = params.dig(:data, :relationships, :user, :data)
      rating[:user_id] = data[:id]
    end

    if data = params.dig(:data, :relationships, :service, :data)
      rating[:service_id] = data[:id]
    end

    rating
  end

  def update_params
    rating = params[:data].require(:attributes).permit(
      :rating
    )

    rating
  end
end
