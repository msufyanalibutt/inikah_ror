class UserDeviseMailer < Devise::Mailer
  include Devise::Controllers::UrlHelpers # eg. `confirmation_url`
  default from: ENV['SMTP_FROM']
  layout  'mailer'
end