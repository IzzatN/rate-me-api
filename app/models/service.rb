class Service < ApplicationRecord
  has_many :service_categories
  has_many :categories, through: :service_categories, source: :category
  has_many :comments
  belongs_to :company

  validates :name, presence: true, uniqueness: true
end
