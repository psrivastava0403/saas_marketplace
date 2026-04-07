class PublicClientsController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    client = Client.create!(client_params)
    render json: client, status: :created
  end

  private

  def client_params
    params.permit(:name, :email, :phone)
  end
end