class ClientRegistrationService
  def initialize(company:, params:)
    @company = company
    @params = params
  end

  def call
    client = find_or_create_global_client
    company_client = find_or_create_company_client(client)

    company_client
  end

  private

  attr_reader :company, :params

  def find_or_create_global_client
    client = Client.find_by(email: params[:email]) ||
             Client.find_by(phone: params[:phone])

    return client if client.present?

    Client.create!(
      name: params[:name],
      email: params[:email],
      phone: params[:phone]
    )
  end

  def find_or_create_company_client(client)
    CompanyClient.find_or_create_by!(
      company: company,
      client: client
    ) do |cc|
      cc.name = params[:name]
      cc.email = params[:email]
      cc.phone = params[:phone]
    end
  end
end