FactoryBot.define do
  factory :user do
    name { 'guest' }
    email { 'guest@test.com' }
    password { 'guest123456' }
    admin { 'false' }
  end
  factory :user2, class: User do
    name { 'guest2' }
    email { 'guest2@test.com' }
    password { 'guest123456' }
    admin { 'false' }
  end
  factory :admin_user, class: User do
    name { 'admin_user' }
    email { 'admin_user@test.com' }
    password { 'test123456' }
    admin { 'true' }
  end
end