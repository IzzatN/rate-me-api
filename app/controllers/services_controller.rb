class ServicesController < ApplicationController
  skip_before_action :authenticate

  def index
    services = Service.all

    if params[:company_id]
      services = services.where(company_id: params[:company_id])
    end

    if params[:category_id]
      services = services.joins(:service_categories)
        .where(service_categories: { category_id: params[:category_id] })
    end

    render json: ServiceSerializer.new(services).serializable_hash
  end

  def show
    service = Service.find(params[:id])

    if service
      render json: ServiceSerializer.new(service).serializable_hash
    else
      data = { errors: [status: 404, code: 'NotFound', detail: "Record not found"] }
      render json: data, status: :not_found
    end
  end

  def destroy
    Service.destroy(params[:id])
    render json: {}, status: :no_content
  end

  def create
    service = Service.new(create_params)

    if service.save
      render json: ServiceSerializer.new(service).serializable_hash
    else
      data = { errors: [status: 422, code: 'UnprocessableEntity', details: service.errors.messages] }
      render json: data, status: :unprocessable_entity
    end
  end

  def update
    service = Service.find(params[:data][:id])

    if service.update(update_params)
      render json: ServiceSerializer.new(service).serializable_hash
    else
      data = { errors: [status: 422, code: 'UnprocessableEntity', details: service.errors.messages] }
      render json: data, status: :unprocessable_entity
    end
  end

  private

  def create_params
    service = params[:data].require(:attributes).permit(
      :name,
      :description
    )

    if data = params.dig(:data, :relationships, :company, :data)
      service[:company_id] = data[:id]
    end

    if data = params.dig(:data, :relationships, :categories, :data)
      service[:categories_ids] = data.map{|d| d[:id]}
    end

    service
  end

  def update_params
    service = params[:data].require(:attributes).permit(
      :name,
      :description
    )

    if data = params.dig(:data, :relationships, :categories, :data)
      service[:categories_ids] = data.map{|d| d[:id]}
    end

    service
  end
end
