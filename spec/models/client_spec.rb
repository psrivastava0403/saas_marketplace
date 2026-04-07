require 'rails_helper'

RSpec.describe Client, type: :model do
  it "generates dummy email if missing" do
    client = Client.create!(name: "Test", phone: "999")

    expect(client.email).to include("@noemail.com")
  end

  it "requires email or phone" do
    client = Client.new(name: "Test")

    expect(client.valid?).to be false
  end
end