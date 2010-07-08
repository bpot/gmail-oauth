module GmailOAuth
  # Client.new("user@gmail.com", :access_token => @access_token)
  # Client.new("user@mywork.com", :consumer => @consumer)
  class Client
    def initialize(email_address, options = {})
      raise ArgumentError, "Must provide either an access token (3legged oauth) or a consumer (2legged oauth)" if options[:access_token].nil? && options[:consumer].nil?
      
      @email_address  = email_address
      @access_token   = options[:access_token]
      if @access_token
        @consumer       = @access_token.consumer
      else
        @consumer       = options[:consumer]
      end
      @service        = options[:service] || :imap
    end

    def xoauth_string
      params = request["parameters"].merge("oauth_signature" => signature)

      prefix = "GET #{request["uri"]} "
      prefix + params.keys.sort.select { |k| k != "xoauth_requestor_id" }.collect { |k| "#{k}=\"#{CGI.escape(params[k])}\"" }.join(",")
    end

    private
    def signature
      OAuth::Signature.sign(request, :scheme => 'header') { [access_token_secret, @consumer.secret] } 
    end

    def access_token_secret
      @access_token ? @access_token.secret : nil
    end

    def request
      @request ||= Request.new(@email_address, @access_token, @consumer, @service).request
    end
  end
end
