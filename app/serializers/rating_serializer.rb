class RatingSerializer
  include FastJsonapi::ObjectSerializer

  set_type :rating

  attributes :value

  belongs_to :user
  belongs_to :service
end
