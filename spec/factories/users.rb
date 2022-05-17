FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    username { Faker::FunnyName.name }
    location { Faker::Address.city }
    password { "password"}
    password_confirmation { "password"}
  end
end