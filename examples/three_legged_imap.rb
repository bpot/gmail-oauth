$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'
require 'rubygems'
require 'gmail-oauth'

raise ArgumentError, "please provide email address (ruby examples/three_legged_imap.rb [email_address])" unless ARGV[0]

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

#Net::IMAP.debug = true
imap = Net::IMAP.new('imap.gmail.com',993,true)
imap.authenticate('XOAUTH', gmail_address, :access_token => access_token)
imap.list("*","*").each do |folder|
  puts folder.name
end
