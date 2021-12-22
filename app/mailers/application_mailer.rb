class ApplicationMailer < ActionMailer::Base
  # default from: ENV['MY_MAIL']
  default from: 'kebabs.com'
  layout 'mailer'
end
