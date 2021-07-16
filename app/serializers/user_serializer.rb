class UserSerializer
  include FastJsonapi::ObjectSerializer

  set_type :user

  attributes  :first_name,
              :last_name,
              :description,
              :email,
              :photo_url,
              :phone,
              :is_consumer
end
