class ClientRegistrationService
  def initialize(company:, params:)
    @company = company
    @params = params
  end

  def call
    client = find_or_create_global_client
    find_or_create_company_client(client)
  end

  private

  attr_reader :company, :params

  def find_or_create_global_client
    Client.find_by(email: params[:email]) ||
    Client.find_by(phone: params[:phone]) ||
    Client.create!(params)
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