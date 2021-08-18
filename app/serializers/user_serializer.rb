class UserSerializer
  include FastJsonapi::ObjectSerializer

  set_type :user

  attributes  :first_name,
              :last_name,
              :email,
              :photo_url,
              :phone,
              :is_consumer

  attribute :full_name do |record|
    "#{record.first_name} #{record.last_name}"
  end
end
