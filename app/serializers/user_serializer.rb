class UserSerializer
  include FastJsonapi::ObjectSerializer

  set_type :user

  attributes  :first_name,
              :last_name,
              :email,
              :photo_url,
              :phone,
              :is_consumer,
              :is_registered

  attribute :full_name do |record|
    "#{record.first_name} #{record.last_name}"
  end

  has_one :auth_session, if: Proc.new { |record, params| params && params[:include_auth] == true }, record_type: :auth_session do |user|
    user.auth_sessions.last
  end

  has_many :companies
end
