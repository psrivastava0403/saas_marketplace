class AuthService
  def self.login(email, password)
    user = User.find_by(email: email)
    return nil unless user&.authenticate(password)

    token = JsonWebToken.encode(user_id: user.id)

    { user: user, token: token }
  end
end