# kindly generated by appropriated Rails generator
# frozen_string_literal: true
require 'mailjet'
Mailjet.configure do |config|
config.api_key = '198779cd9053c6ed63f0590c533f3992'
config.secret_key = '21b999330198cc2f2de552de895bb7ce'
config.api_version = "v3.1"
end

=begin
Mailjet.configure do |config|
  config.api_key = ENV['MAILJET_API_KEY']
  config.secret_key = ENV['MAILJET_SECRET_KEY']
  config.default_from = ENV['MY_MAIL']
end 
=end
