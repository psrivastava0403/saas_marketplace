class OrderCreationService
  def initialize(company:, params:)
    @company = company
    @params = params
  end

  def call
    product = company.products.find(params[:product_id])
    client = company_client.client

    Order.create!(
      company: company,
      product: product,
      client: client,
      quantity: params[:quantity]
    )
  end

  private

  attr_reader :company, :params

  def company_client
    company.company_clients.find(params[:company_client_id])
  end
end