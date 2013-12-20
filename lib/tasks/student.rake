require 'rest-client'

namespace :students do
  desc "scrape white belts email and users" 
    task :clean  => :environment do
      Student.remove_invalid_users
    end
end
