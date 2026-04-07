FactoryBot.define do
  factory :product do
    name { "Laptop" }
    price { 1000 }
    association :company
  end
end