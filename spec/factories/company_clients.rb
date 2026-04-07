FactoryBot.define do
  factory :company_client do
    company { nil }
    client { nil }
    name { "MyString" }
    email { "MyString" }
    phone { "MyString" }
  end
end
