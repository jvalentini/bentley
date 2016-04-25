require 'gmail'
require 'nokogiri'

username = ENV['GMAIL_USERNAME']
password = ENV['GMAIL_PASSWORD']
gmail = Gmail.connect!(username, password)

emails = gmail.inbox.find(from: 'alert@indeed.com')
emails.map do |email|
  puts email.message_id

  msg = email.message
  puts msg.subject, msg.date.to_s

  if msg.multipart?
    puts Nokogiri::HTML(msg.body.parts[0].decoded).at_css('#job_header').text
  else
    puts Nokogiri::HTML(msg.body.decoded).at_css('#job_header').text
  end
end
