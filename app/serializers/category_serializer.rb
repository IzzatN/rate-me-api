class CategorySerializer
  include FastJsonapi::ObjectSerializer

  set_type :categories

  attributes  :name,
              :value
end
