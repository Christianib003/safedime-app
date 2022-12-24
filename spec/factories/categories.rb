FactoryBot.define do
  factory :category do
    name { Faker::Name.name }
    icon { Faker::Internet.url }
  end
end
