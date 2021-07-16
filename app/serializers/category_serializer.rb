class CategoriesSerializer
  include FastJsonapi::ObjectSerializer

  set_type :categories

  attributes  :name,
              :value
end
