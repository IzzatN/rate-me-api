class CompaniesController < ApplicationController

  def index
    companies = Company.all

    render json: CompanySerializer.new(companies).serializable_hash
  end

  def show
    company = Company.find(params[:id])

    if company
      render json: CompanySerializer.new(company).serializable_hash
    else
      data = { errors: [status: 404, code: 'NotFound', detail: "Record not found"] }
      render json: data, status: :not_found
    end
  end

  # def destroy
  #   Company.destroy(params[:id])
  #   render json: {}, status: :no_content
  # end

  def create
    company = Company.new(create_params)

    if company.save
      render json: CompanySerializer.new(company).serializable_hash
    else
      data = { errors: [status: 422, code: 'UnprocessableEntity', details: company.errors.messages] }
      render json: data, status: :unprocessable_entity
    end
  end

  def update
    company = Company.find(params[:data][:id])

    if company.update(update_params)
      render json: CompanySerializer.new(company).serializable_hash
    else
      data = { errors: [status: 422, code: 'UnprocessableEntity', details: company.errors.messages] }
      render json: data, status: :unprocessable_entity
    end
  end

  private

  def create_params
    company = params[:data].require(:attributes).permit(
      :name,
      :short_name,
      :description,
      :logo_url,
      :address,
      :background_img_url,
      :contact_phone
      :is_branch
    )

    if data = params.dig(:data, :relationships, :parent, :data)
      company[:parent_id] = data[:id]
    end

    company
  end

  def update_params
    company = params[:data].require(:attributes).permit(
      :name,
      :short_name,
      :description,
      :logo_url,
      :address,
      :background_img_url,
      :contact_phone
      :is_branch
    )

    if data = params.dig(:data, :relationships, :parent, :data)
      company[:parent_id] = data[:id]
    end

    company
  end
end
