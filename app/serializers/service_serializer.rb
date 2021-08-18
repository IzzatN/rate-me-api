class ServiceSerializer
  include FastJsonapi::ObjectSerializer

  set_type :service

  attributes  :name,
              :description,
              :updated_at

  has_many :categories
  has_many :comments

  belongs_to :company
end
