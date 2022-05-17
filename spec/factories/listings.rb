FactoryBot.define do
  factory :listing do
    quantity { rand(10) }
    category { ["seeds", "clippings", "plant"].sample }
    description { Faker::Lorem.sentence }
    rooted { Faker::Boolean.boolean(true_ratio: 0.9) }
    active { Faker::Boolean.boolean(true_ratio: 0.9) }
    user
    plant
  end
end