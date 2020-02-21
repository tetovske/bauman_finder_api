FactoryBot.define do
  factory :default_user, class: User do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    bf_api_token { Faker::Internet.password }
    confirmed_at { Date.today }
  end

  factory :admin, class: User do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    bf_api_token { Faker::Internet.password }
    is_admin { true }
    confirmed_at { Date.today }
  end
end