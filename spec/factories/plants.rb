FactoryBot.define do
  factory :plant do
    photo { Faker::LoremFlickr.image }
    plant_type { Faker::Cannabis.strain }
    indoor { Faker::Boolean.boolean(true_ratio: 0.2) }
    user
  end
end