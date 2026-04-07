class ClientsController < ApplicationController
  def create
    company_client = ClientRegistrationService.new(
      company: current_company,
      params: client_params
    ).call

    render json: company_client
  end

  def index
    clients = current_company.company_clients.includes(:client)
    render json: clients
  end

  private

  def client_params
    params.permit(:name, :email, :phone)
  end
end