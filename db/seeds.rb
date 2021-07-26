company = Company.create(
  name: 'company 1',
  short_name: 'test company',
  description: 'dasda dasdasda ad',
  logo_url: 'https://images.unsplash.com/photo-1472099645785-56…to=format&fit=facearea&facepad=2&w=256&h=256&q=80',
  address: 'amir temur 48',
  background_img_url: 'https://images.unsplash.com/photo-1472099645785-56…to=format&fit=facearea&facepad=2&w=256&h=256&q=80',
  is_branch: false,
  contact_phone: '132123123',
  created_at: DateTime.now,
  updated_at: DateTime.now,
  parent_id: nil
)

# user1 = User.create(
#   email: 'test@user.com',
#   first_name: 'test',
#   last_name: 'user',
#   phone: '1321313',
#   photoUrl: nil,
#   is_consumer: false,
#   created_at: DateTime.now,
#   updated_at: DateTime.now
# )

# user2 = User.create(
#   email: 'test@user2.com',
#   first_name: 'test',
#   last_name: 'user2',
#   phone: '132131dsad3',
#   photoUrl: nil,
#   is_consumer: true,
#   created_at: DateTime.now,
#   updated_at: DateTime.now
# )

service1 = Service.create(
  name: 'test 1',
  description: 'dasda dasdasda ad',
  created_at: DateTime.now,
  updated_at: DateTime.now,
  company_id: company.id
)

service2 = Service.create(
  name: 'test 2',
  description: 'dasda dasdasda ad',
  created_at: DateTime.now,
  updated_at: DateTime.now,
  company_id: company.id
)

category1 = Category.create(
  name: 'test 1',
  value: 'test_1'
)

category2 = Category.create(
  name: 'test 2',
  value: 'test_2'
)

service1.categories << category1
service2.categories << category2
