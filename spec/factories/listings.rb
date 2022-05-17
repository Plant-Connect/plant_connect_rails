FactoryBot.define do
  factory :listing do
    quantity { rand(10) }
    category { ["seeds", "clippings", "plant"].sample }
    description { Faker::Lorem.sentence }
    rooted { Faker::Boolean.boolean(true_ratio: 0.2) }
    active { Faker::Boolean.boolean(true_ratio: 0.2) }
    user
    plant
  end
end