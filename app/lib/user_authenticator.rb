class UserAuthenticator
  class AuthenticationError < StandardError; end
  attr_reader :user

  def initialize(code)
    @code = code
  end

  def perform
    client = Octokit::Client.new(
      client_id: ENV['GIHUB_CLIENT_ID'],
      client_secret: ENV['GITHUB_CLIENT_SECRET']
    )
    token = client.exchange_code_for_token(code)
    if token.try(:error).present? #only try if there is error on token [token.error] if no error return nil
      raise AuthenticationError
    else
      #Terminal 
      #user_registration
      #client = Octokit::Client.new(client_id: 'xxx', client_secret: 'xxx')
      #client.user('richill').to_h.slice(:logiin, :avatar_url, :url, :name)
      user_client = Octokit::Client.new(access_token: token)
      user_data = client.user(user_client).to_h.slice(:login, :avatar_url, :url, :name)
      User.create(user_data.merge(provider: 'github'))
    end
  end

  private

  attr_reader :code
end
