require 'rails_helper'

RSpec.describe CompanyClient, type: :model do
  let(:company) { Company.create!(name: "Test") }
  let(:client) { Client.create!(name: "Rahul", phone: "999") }

  it "is valid" do
    cc = CompanyClient.new(company: company, client: client)
    expect(cc).to be_valid
  end

  it "belongs to company" do
    assoc = CompanyClient.reflect_on_association(:company)
    expect(assoc.macro).to eq(:belongs_to)
  end

  it "belongs to client" do
    assoc = CompanyClient.reflect_on_association(:client)
    expect(assoc.macro).to eq(:belongs_to)
  end
end