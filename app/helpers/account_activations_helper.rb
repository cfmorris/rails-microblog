module AccountActivationsHelper
  def smtp_settings
    ActionMailer.Base.smtp_settings = {
          :addresses      => 'smtp.sendgrid.net',
          :port           => '587',
          :authentication => :plain,
          :user_name      => 'apikey',
          :password       => ENV['SENDGRID_API_KEY'],
          :domain        => 'heroku.com',
          :enable_starttls_auto => true
    }
  end
end
