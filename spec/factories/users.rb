FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    username { Faker::FunnyName.name }
    location { Faker::Address.city }
    password_digest {Faker::Alphanumeric.alphanumeric(number: 10)}
  end
end