class OrderSerializer < ActiveModel::Serializer
  attributes :id, :quantity

  belongs_to :product
  belongs_to :client
end