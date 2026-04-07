require 'rails_helper'

RSpec.describe "Auth", type: :request do
  it "signup creates user and company" do
    post "/signup", params: {
      name: "Admin",
      email: "admin@test.com",
      password: "123456",
      company_name: "TestCo"
    }

    expect(response).to have_http_status(:ok)
  end
end