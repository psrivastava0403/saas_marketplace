FactoryBot.define do
  factory :order do
    company { nil }
    client { nil }
    product { nil }
    quantity { 1 }
  end
end
