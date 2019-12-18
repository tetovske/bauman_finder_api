# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  :user_name => 'apikey',
  :password => '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',
  :domain => 'baumanfinder@ya.ru',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}
