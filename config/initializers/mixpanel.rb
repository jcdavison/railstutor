if Rails.env.production? 
  Rails.configuration.mixpanelkey = ENV['RAILS_TUTOR_MP_PROD']
else
  Rails.configuration.mixpanelkey = ENV['RAILS_TUTOR_MP_DEV']
end

