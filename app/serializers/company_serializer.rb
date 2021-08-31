class CompanySerializer
  include FastJsonapi::ObjectSerializer

  set_type :company

  attributes  :name,
              :short_name,
              :description,
              :address,
              :logo_url,
              :background_img_url,
              :contact_phone,
              :email,
              :is_branch

  belongs_to :user
  belongs_to :parent, record_type: :company
  has_many :branches, record_type: :company
  has_many :services
end
