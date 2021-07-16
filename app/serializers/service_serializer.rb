class ServiceSerializer
  include FastJsonapi::ObjectSerializer

  set_type :service

  attributes  :name,
              :description

  has_many :categories
  belongs_to :company
end
