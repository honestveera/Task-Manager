class ApplicationMailer < ActionMailer::Base
  default from: ENV['username']
  layout 'mailer'
end
