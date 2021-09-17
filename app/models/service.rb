class Service < ApplicationRecord
  has_many :service_categories
  has_many :categories, through: :service_categories, source: :category
  has_many :comments
  has_many :ratings, dependent: :destroy
  belongs_to :company

  validates :name, presence: true, uniqueness: true

  def rank
    if self.ratings.any?
      self.ratings.average(:value)
    end
  end
end
