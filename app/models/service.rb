class Services < ApplicationRecord
  has_many :service_categories
  has_many :categories, through: :service_categories, source: :category
  belongs_to :company

  validates :name, presence: true, uniqueness: true
end
