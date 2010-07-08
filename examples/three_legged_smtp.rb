$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'
require 'rubygems'
require 'gmail-oauth'

raise ArgumentError, "please provide email address (ruby examples/three_legged_smtp.rb [email_address])" unless ARGV[0]

gmail_address = ARGV[0]

consumer = OAuth::Consumer.new("anonymous", "anonymous", 
                               :site => "https://www.google.com", 
                               :request_token_path => "/accounts/OAuthGetRequestToken",
                               :authorize_path => "/accounts/OAuthAuthorizeToken",
                               :access_token_path => "/accounts/OAuthGetAccessToken")

rt = consumer.get_request_token({:oauth_callback => "oob"}, {:scope => "https://mail.google.com/"})
print rt.authorize_url + "\n"
print "Enter verification code: "
code = $stdin.gets.chomp
access_token = rt.get_access_token(:oauth_verifier => code)


 msgstr = <<END_OF_MESSAGE
    From: Blah <#{gmail_address}>
    To: Destination Address <#{gmail_address}>
    Subject: test message
    Date: Sat, 23 Jun 2001 16:26:43 +0900
    Message-Id: <unique.message.id.string@example.com>

    This is a test message.
END_OF_MESSAGE

smtp = Net::SMTP.new('smtp.gmail.com')
smtp.enable_starttls
smtp.debug_output = $stdout
#smtp.enable_tls
smtp.start('gmail.com', gmail_address, {:access_token => access_token}, :xoauth)
smtp.send_message msgstr, gmail_address, gmail_address
smtp.finish
