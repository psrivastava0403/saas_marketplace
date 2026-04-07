require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:company) { Company.create!(name: "Test") }

  it "is valid with attributes" do
    product = Product.new(
      name: "Laptop",
      price: 1000,
      company: company
    )

    expect(product).to be_valid
  end

  it "requires name" do
    product = Product.new(price: 1000, company: company)
    expect(product).not_to be_valid
  end

  it "belongs to company" do
    assoc = Product.reflect_on_association(:company)
    expect(assoc.macro).to eq(:belongs_to)
  end
end