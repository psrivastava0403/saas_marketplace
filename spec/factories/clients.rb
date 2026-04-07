FactoryBot.define do
  factory :client do
    name { "Rahul" }
    email { Faker::Internet.email }
  end
end