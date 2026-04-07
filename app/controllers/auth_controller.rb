class AuthController < ApplicationController
  skip_before_action :authenticate_user!, only: [:signup, :login]

  def signup
    company = Company.create!(name: params[:company_name])

    user = company.users.create!(
      name: params[:name],
      email: params[:email],
      password: params[:password]
    )

    token = JsonWebToken.encode(user_id: user.id)

    render json: { token: token }
  end

  def login
    result = AuthService.login(params[:email], params[:password])

    return render json: { error: "Invalid credentials" }, status: :unauthorized unless result

    render json: { token: result[:token] }
  end
end