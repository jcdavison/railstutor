if Rails.env.production? 
  Rails.configuration.mixpanelkey = ENV['RAILS_TUTOR_MIXPANEL_PROD']
else
  Rails.configuration.mixpanelkey = ENV['RAILS_TUTOR_MIXPANEL_DEV']
end

