gmail-oauth
===========

Implements Gmail OAuth access methods for Net::IMAP and Net::SMTP

Fully working examples (including fetching the access_token) for smtp and imap are in examples/

IMAP Usage
----------

    imap = Net::IMAP.new('imap.gmail.com',993,true)

    # For 3legged oauth provide an OAuth::AcessToken
    imap.authenticate('XOAUTH', "example@gmail.com", :access_token => access_token)

    # For 2legged oauth just provide the OAuth::Consumer
    #imap.authenticate('XOAUTH', "example@gmail.com", :consumer => consumer)

    imap.list("*","*").each do |folder|
      puts folder.name
    end

SMTP Usage
----------

    raw_email = generate_email()  

    smtp = Net::SMTP.new('smtp.gmail.com')
    smtp.enable_starttls
    smtp.start('gmail.com', "example@gmail.com", {:access_token => access_token}, :xoauth)
    smtp.send_message raw_email, "example@gmail.com", "destination@gmail.com"
    smtp.finish

== Copyright

Copyright (c) 2010 Bob Potter. See LICENSE for details.
