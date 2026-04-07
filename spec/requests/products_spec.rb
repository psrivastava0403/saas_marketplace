require 'rails_helper'

RSpec.describe "Products", type: :request do
  let(:company) { create(:company) }
  let(:user) { create(:user, company: company) }
  let(:token) { JsonWebToken.encode(user_id: user.id) }

  it "creates product" do
    post "/products",
      params: { name: "Laptop", price: 1000 },
      headers: { "Authorization" => "Bearer #{token}" }

    expect(response).to have_http_status(:created)
  end
end