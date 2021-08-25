class CategoriesController < ApplicationController
  skip_before_action :authenticate
  # after_action :verify_authorized
  # before_action :authenticate

  def index
    categories = Category.all

    render json: CategorySerializer.new(categories).serializable_hash
  end

  def show
    categories = Category.all

    # support id or slug as param
    category =
      if params[:id] =~ /^\d+$/
        categories.find(params[:id])
      else
        category_ids = Category.where(value: params[:id]).pluck(:id)
        categories.where(id: category_ids).first
      end

    if category
      render json: CategorySerializer.new(category).serializable_hash
    else
      data = { errors: [status: 404, code: 'NotFound', detail: "Record not found"] }
      render json: data, status: :not_found
    end
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
