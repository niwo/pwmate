require "faraday"
require "base64"

class CryptopusStore

  def initialize(user, token, options = {})
    @user = user
    @token = options[:cryptopus_token]
    @api_url = options[:cryptopus_api_url]
    Typhoeus::Config.user_agent = "pwmate"
  end

  def get_secret(account_id)
    resp = Faraday.get(
      "#{@api_url}/accounts/#{account_id}",
      headers: http_headers()
    )
    resp.response.code == 200 ? resp.response.body : nil
  end

  def set_secret(account_id, secret)
    resp = Faraday.patch(
      "#{@api_url}/accounts/#{account_id}",
      headers: http_headers(),
      body: { password: secret }
    )
    resp.response.code == 200
  end

  private

  def http_headers
    {
      'Content-Type': "application/json",
      'Accept': "application/json",
      'Authorization-User': @user,
      'Authorization-Password': Base64.encode64(@token)
    }
  end

end