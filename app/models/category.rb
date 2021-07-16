class Categories < ApplicationRecord
  has_many :service_categories
  has_many :services, through: :service_categories, source: :service
end
