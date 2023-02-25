# frozen_string_literal: true

require 'google/apis/gmail_v1'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'mail'

# This class is for Configuration
class Configuration
  CLIENT_SECRET_FILE = 'client_secret.json'
  OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'
  SCOPE = 'https://mail.google.com/'
  @client_id = Google::Auth::ClientId.from_file(CLIENT_SECRET_FILE)
  @token_store = Google::Auth::Stores::FileTokenStore.new(file: 'token.yaml')
  @authorize = Google::Auth::UserAuthorizer.new(@client_id, SCOPE, @token_store)
  @gmail = Google::Apis::GmailV1::GmailService.new

  def authorizer
    @credentials.nil?
    @url = @authorize.get_authorization_url(base_url: OOB_URI)
    puts 'Open the following URL in the browser and enter the resulting code after authorization'
    puts @url
    @code = gets
    @credentials = @authorize.get_and_store_credentials_from_code(user_id: @user_id, code: @code, base_url: OOB_URI)
  end

  def self.client
    @user_id = 'me'
    @credentials = @authorize.get_credentials(@user_id)
    @gmail.authorization = @credentials
    @gmail
  end
end
