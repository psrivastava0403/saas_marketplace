class OrdersController < ApplicationController
  def create
    order = OrderCreationService.new(
      company: current_company,
      params: order_params
    ).call

    render json: order, status: :created
  end

  def index
    orders = current_company
               .orders
               .includes(:product, :client)

    render json: orders
  end

  private

  def order_params
    params.permit(:product_id, :company_client_id, :quantity)
  end
end