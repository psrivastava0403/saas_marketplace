class Company < ApplicationRecord
  has_many :users
  has_many :products
  has_many :company_clients
  has_many :orders
end