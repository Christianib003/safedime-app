FactoryBot.define do
  factory :payment do
    name { Faker::Name.name }
    amount { 9.99 }
  end
end
