require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe GmailOAuth::Request do

  def consumer
    OAuth::Consumer.new('consumer_key','secret')
  end

  def access_token
    OAuth::AccessToken.new(consumer, 'access_token','secret')
  end

  context "2legged imap" do
    before(:each) do
      @request = GmailOAuth::Request.new("user@mywork.com", nil, consumer)
    end

    it "should have the correct request uri" do
      @request.request["uri"].should == "https://mail.google.com/mail/b/user@mywork.com/imap/?xoauth_requestor_id=user%40mywork.com"
    end

    it "should have oauth_version of 1.0" do
      @request.request["parameters"]["oauth_version"].should == "1.0"
    end

    it "should have oauth_signature_method of HMAC_SHA1" do
      @request.request["parameters"]["oauth_signature_method"].should == "HMAC-SHA1"
    end

    it "should use access token's consumer's key" do
      @request.request["parameters"]["oauth_consumer_key"].should == "consumer_key"
    end

    it "should have the email as the xoauth_requestor_id parameter" do
      @request.request["parameters"]["xoauth_requestor_id"].should == "user@mywork.com"
    end
  end

  context "3legged imap" do
    before(:each) do
      @request = GmailOAuth::Request.new("user@gmail.com", access_token, consumer)
    end

    it "should have the correct request uri" do
      @request.request["uri"].should == "https://mail.google.com/mail/b/user@gmail.com/imap/"
    end

    it "should use access token's consumer's key" do
      @request.request["parameters"]["oauth_consumer_key"].should == "consumer_key"
    end

    it "should have the access token as the oauth_token parameter" do
      @request.request["parameters"]["oauth_token"].should == "access_token"
    end
  end

  context "3legged smtp" do
    before(:each) do
      @request = GmailOAuth::Request.new("user@gmail.com", access_token, consumer, :smtp)
    end

    it "should have the correct request uri" do
      @request.request["uri"].should == "https://mail.google.com/mail/b/user@gmail.com/smtp/"
    end
  end
end
