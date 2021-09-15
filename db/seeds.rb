require 'database_cleaner/active_record'

DatabaseCleaner.strategy = :truncation

# then, whenever you need to clean the DB
DatabaseCleaner.clean

# Users ------------------------------

yoshi = User.create(
  first_name: 'Yoshi',
  last_name: 'Dreams',
  email:'dreams@autoritet.com',
  phone: '1321313',
  photo_url: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=4&w=256&h=256&q=60',
  password: 'password',
  is_registered: true,
  is_consumer: false
)

sarvar = User.create(
  email: 'sarvar@potribitel.uz',
  first_name: 'Sarvar',
  last_name: 'Samatov',
  phone: '8532234324',
  photo_url: 'https://images.unsplash.com/photo-1550525811-e5869dd03032?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80',
  password: 'password',
  is_registered: true,
  is_consumer: true
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

# Companies ------------------------------

autoritet = Company.create(
  name: 'Autoritet',
  short_name: 'Autoritet',
  description: 'Set autoservisov Avtoritet',
  logo_url: 'https://newopen.uz/img/adaf829df49742c1d3d32a49442a9a04.jpg',
  address: 'amir temur 48',
  background_img_url: 'https://www.spot.uz/media/img/2020/01/qKOh1T15792661371919_b.jpg',
  is_branch: false,
  contact_phone: '132123123',
  parent_id: nil,
  email: 'galavnoy@autoritet.com',
  user: yoshi
)

# Services ------------------------------

vulkanizatsiya1 = Service.create(
  name: 'Vulkanizatsiya xizamtlari',
  description: 'Balon yamash, ...',
  company_id: autoritet.id,
  updated_at: 5.days.ago.to_datetime,
  created_at: 5.days.ago.to_datetime
)

remont_kuzova = Service.create(
  name: 'Kuzovnoy remont',
  description: 'Remont lyubix chastey kuzova',
  company_id: autoritet.id,
  updated_at: 2.days.ago.to_datetime,
  created_at: 2.days.ago.to_datetime
)

addinol = Service.create(
  name: 'Moy almashtirish (Addinol)',
  description: 'Addinol firmasining moy almashtirish xizmati',
  company_id: autoritet.id,
  updated_at: 10.days.ago.to_datetime,
  created_at: 10.days.ago.to_datetime
)

total = Service.create(
  name: 'Moy almashtirish (Total)',
  description: 'Total firmasining moy almashtirish xizmati',
  company_id: autoritet.id,
  updated_at: 21.days.ago.to_datetime,
  created_at: 21.days.ago.to_datetime
)

t_koreyskiy = Service.create(
  name: 'Krugovaya tonirokva',
  description: 'Tonirokva xizmati',
  company_id: autoritet.id,
  updated_at: 12.days.ago.to_datetime,
  created_at: 12.days.ago.to_datetime
)

t_mestniy = Service.create(
  name: 'Tonirovka Sobiraka',
  description: 'Tonirokva xizmati',
  company_id: autoritet.id,
  updated_at: 12.days.ago.to_datetime,
  created_at: 12.days.ago.to_datetime
)

liqui_moly = Service.create(
  name: 'Moy almashtirish (Liqui Moly)',
  description: 'Liqui Moly firmasining moy almashtirish xizmati',
  company_id: autoritet.id,
  updated_at: 3.days.ago.to_datetime,
  created_at: 3.days.ago.to_datetime
)

mohir_fara = Service.create(
  name: 'Restavraciya fara (Mohir Fara)',
  description: 'Chistka, restavraciya, tuning fara',
  company_id: autoritet.id,
  updated_at: 8.days.ago.to_datetime,
  created_at: 8.days.ago.to_datetime
)
# Categories ------------------------------

shinomontaj = Category.create(
  name: 'Shinomontaj',
  value: 'shinomontaj'
)

moy_almashtirish = Category.create(
  name: 'Moy almashtirish',
  value: 'moy_almashtirish'
)

evakuator = Category.create(
  name: 'Evakuator',
  value: 'evakuator'
)

kostoprav = Category.create(
  name: 'Kostoprav',
  value: 'kostoprav'
)

tonirovka = Category.create(
  name: 'Tonirovka',
  value: 'tonirovka'
)

moyka = Category.create(
  name: 'Moyka',
  value: 'moyka'
)

elektrik = Category.create(
  name: 'Elektrik',
  value: 'elektrik'
)


# Categories/Services ------------------------------

vulkanizatsiya1.categories << shinomontaj
remont_kuzova.categories << kostoprav
remont_kuzova.categories << kostoprav
mohir_fara.categories << elektrik
addinol.categories << moy_almashtirish
liqui_moly.categories << moy_almashtirish
total.categories << moy_almashtirish
t_koreyskiy.categories << tonirovka
t_mestniy.categories << tonirovka
