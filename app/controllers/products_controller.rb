class ProductsController < ApplicationController
  def index
    products = current_company.products
    render json: products
  end

  def create
    product = current_company.products.create!(product_params)
    render json: product, status: :created
  end

  private

  def product_params
    params.permit(:name, :description, :price)
  end
end