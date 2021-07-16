class CategoriesController < ApplicationController

  def index
    category = Category.all

    render json: CategorySerializer.new(category).serializable_hash
  end

  # def create
  #   category = Category.new(create_params)

  #   if category.save
  #     render json: CategorySerializer.new(category).serializable_hash
  #   else
  #     data = { errors: [status: 422, code: 'UnprocessableEntity', details: category.errors.messages] }
  #     render json: data, status: :unprocessable_entity
  #   end
  # end

  private

  # def create_params
  #   category = params[:data].require(:attributes).permit(
  #     :name,
  #     :value
  #   )

  #   category
  # end
end
