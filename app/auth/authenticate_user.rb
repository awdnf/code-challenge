class AuthenticateUser
  def initialize(email, password)
    @email = email
    @password = password
  end

  # Service entry point
  def call
    valid_user = verify_user
    JsonWebToken.encode(user: {
        id: valid_user.id,
        name: valid_user.name,
        email: valid_user.email
    }) if valid_user
  end

  private

  attr_reader :email, :password

  # verify user credentials
  def verify_user
    user = User.find_by(email: email)
    return user if user && user.authenticate(password)
    # raise Authentication error if credentials are invalid
    raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
  end
end
