class Product < ApplicationRecord
  belongs_to :company

  has_many :orders

  validates :name, presence: true
  validates :price, presence: true

  scope :with_company, -> { includes(:company) }
end