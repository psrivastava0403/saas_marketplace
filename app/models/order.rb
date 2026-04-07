class Order < ApplicationRecord
  belongs_to :company
  belongs_to :client
  belongs_to :product

  validates :quantity, presence: true, numericality: { greater_than: 0 }

  scope :with_associations, -> { includes(:client, :product) }
end