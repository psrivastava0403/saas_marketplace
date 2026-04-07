require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:company) { Company.create!(name: "Test") }
  let(:client) { Client.create!(name: "Rahul", phone: "999") }
  let(:product) { Product.create!(name: "Laptop", price: 1000, company: company) }

  it "is valid with attributes" do
    order = Order.new(
      company: company,
      client: client,
      product: product,
      quantity: 1
    )

    expect(order).to be_valid
  end

  it "requires quantity" do
    order = Order.new(company: company, client: client, product: product)
    expect(order).not_to be_valid
  end
end
