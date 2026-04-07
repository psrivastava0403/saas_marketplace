class ApplicationController < ActionController::API
  before_action :authenticate_user!

  attr_reader :current_user, :current_company

  private

  def authenticate_user!
    header = request.headers['Authorization']
    token = header.split(' ').last if header

    begin
      decoded = JsonWebToken.decode(token)
      @current_user = User.find(decoded[:user_id])
      @current_company = @current_user.company
    rescue
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end