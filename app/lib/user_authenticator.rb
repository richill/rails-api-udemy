class UserAuthenticator
  AuthenticationError = Class.new(StandardError)

  def initialize(code)
  end

  def perform
    raise AuthenticationError
  end

  def user
  end
end
