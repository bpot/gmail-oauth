require 'gmail-oauth/request'
require 'gmail-oauth/client'
require 'net/imap' unless defined?(Net::IMAP);
require 'net/smtp' unless defined?(Net::SMTP);
require 'oauth'
require 'cgi'

class Net::IMAP
  class XOAuthAuthenticator
    def initialize(email_address, opts = {})
      @email_address = email_address
      @opts = opts
    end

    def process(s)
      GmailOAuth::Client.new(@email_address, @opts).xoauth_string
    end
  end
  add_authenticator 'XOAUTH', XOAuthAuthenticator
end

class Net::SMTP
  def auth_xoauth(email_address, options)
    auth_string = GmailOAuth::Client.new(email_address, options.merge(:service => :smtp)).xoauth_string
    res = critical {
      get_response('AUTH XOAUTH ' + base64_encode(auth_string))
    }
    check_auth_response res
    res
  end
end

