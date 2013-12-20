Stripe.api_key = Rails.configuration.stripe.api_key

if Rails.env.production? 
  Rails.configuration.mixpanelkey = ENV['RAILS_TUTOR_MP_PROD']
else
  Rails.configuration.mixpanelkey = ENV['RAILS_TUTOR_MP_DEV']
end

RAILSTUTOR_MAILGUN = ENV['RAILSTUTOR_MAILGUN']
RAILSTUTOR_PUBLIC_MAILGUN = ENV['RAILSTUTOR_PUBLIC_MAILGUN']
