class CategoriesSerializer
  include FastJsonapi::ObjectSerializer

  set_type :categories

  attributes  :name,
              :description

  has_many :categories
  belongs_to :company
end
