class ApplicationMailer < ActionMailer::Base
  default from: "welcome@cfmorris.dev"
  layout "mailer"
end
