require 'rails_helper'

RSpec.describe User, type: :model do
  let(:company) { Company.create!(name: "Test") }

  it "is valid with attributes" do
    user = User.new(
      name: "Admin",
      email: "admin@test.com",
      password: "password",
      company: company
    )

    expect(user).to be_valid
  end

  it "requires email" do
    user = User.new(name: "Admin", password: "password", company: company)
    expect(user).not_to be_valid
  end

  it "belongs to company" do
    assoc = User.reflect_on_association(:company)
    expect(assoc.macro).to eq(:belongs_to)
  end
end