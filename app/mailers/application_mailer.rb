class ApplicationMailer < ActionMailer::Base
  default from: AppSettings.sendgrid.from_email
  layout 'mailer'

end
