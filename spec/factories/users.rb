FactoryBot.define do
  factory :user do
    name { "Admin" }
    email { Faker::Internet.email }
    password { "password" }
    association :company
  end
end