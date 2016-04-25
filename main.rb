require 'gmail'
require 'nokogiri'

gmail = Gmail.connect!(ENV['GMAIL_USERNAME'], ENV['GMAIL_PASSWORD'])

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
