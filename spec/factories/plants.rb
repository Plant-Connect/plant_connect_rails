FactoryBot.define do
  factory :plant do
    photo { Faker::LoremFlickr.image }
    plant_type { Faker::Cannabis.strain }
    indoor { ["true", "false"].sample }
    user
  end
end