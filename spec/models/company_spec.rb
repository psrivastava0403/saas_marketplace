require 'rails_helper'

RSpec.describe Company, type: :model do
  it "is valid with name" do
    company = Company.new(name: "Test Co")
    expect(company).to be_valid
  end

  it "invalid without name" do
    company = Company.new(name: nil)
    expect(company).not_to be_valid
  end

  it "has many users" do
    assoc = Company.reflect_on_association(:users)
    expect(assoc.macro).to eq(:has_many)
  end

  it "has many products" do
    assoc = Company.reflect_on_association(:products)
    expect(assoc.macro).to eq(:has_many)
  end
end