module GmailOAuth
  class Request
    def initialize(email_address, access_token, consumer, service = :imap)
      @email_address  = email_address
      @consumer       = consumer
      @access_token   = access_token
      @service        = service
    end

    def request
      {
        "uri"     => request_uri,
        "parameters" => parameters,
        "method" => "GET"
      }
    end

    private
    def two_legged?
      !@access_token
    end

    def request_uri
      uri = "https://mail.google.com/mail/b/#{@email_address}/#{@service}/"
      if two_legged?
        uri += "?xoauth_requestor_id=#{CGI.escape(@email_address)}"
      end
      uri
    end

    def parameters
      params = {
        "oauth_signature_method" => "HMAC-SHA1",
        "oauth_version"          => "1.0", 
        "oauth_nonce"            => OAuth::Helper.generate_nonce,
        "oauth_timestamp"        => OAuth::Helper.generate_timestamp,
        "oauth_consumer_key"     => @consumer.key
      }

      if two_legged?
        params["xoauth_requestor_id"] = @email_address
      else
        params["oauth_token"]     = @access_token.token
      end
      params
    end
  end
end
