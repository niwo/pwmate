require "faraday"
require "base64"

class CryptopusStore
  def initialize(user, token)
    @user = user
    @token = token
  end

  def get_cryptopus_secret(account_id)
    resp = Faraday.get("https://cryptopus.puzzle.ch/api/accounts/#{account_id}") do |req|
      req.headers['Content-Type'] = 'application/json'
      req.headers['Authorization-User'] = @user
      req.headers['Authorization-Password'] = Base64.encode64(@token)
    end
  end
end