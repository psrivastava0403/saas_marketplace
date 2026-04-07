class OrderCreationService
  def initialize(company:, params:)
    @company = company
    @params = params
  end

  def call
    Order.create!(
      company: company,
      product: product,
      client: company_client.client,
      quantity: params[:quantity]
    )
  end

  private

  attr_reader :company, :params

  def product
    company.products.find(params[:product_id])
  end

  def company_client
    company.company_clients.find(params[:company_client_id])
  end
end