# frozen_string_literal: true

require 'google/apis/gmail_v1'
require 'googleauth'
require 'googleauth/stores/file_token_store'

# This class is for Configuration
module Configuration
    def self.client
    client_id = Google::Auth::ClientId.from_file('/Users/gdemirev/Desktop/rspec_gmail_api/client_secret.json')
    token_store = Google::Auth::Stores::FileTokenStore.new(file: 'token.yaml')
    authorize = Google::Auth::UserAuthorizer.new(client_id, 'https://mail.google.com/', token_store,)
    gmail = Google::Apis::GmailV1::GmailService.new
    user_id = 'me'
    credentials = authorize.get_credentials(user_id)
    if credentials.nil?
        url = authorize.get_authorization_url('urn:ietf:wg:oauth:2.0:oob')
        puts 'Open the following URL in the browser and enter the resulting code after authorization'
        puts url
        code = gets
        credentials = authorize.get_and_store_credentials_from_code(user_id: user_id, code: code, base_url: 'urn:ietf:wg:oauth:2.0:oob')
    end
    gmail.authorization = credentials
    gmail
    end
end
