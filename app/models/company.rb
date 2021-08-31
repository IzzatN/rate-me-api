class Company < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :parent, class_name: 'Company', optional: true
  has_many :branches, class_name: 'Company', foreign_key: :parent_id
  has_many :services, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :short_name, presence: true
end
