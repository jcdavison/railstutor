require 'rest-client'

namespace :list do
  desc "scrape white belts email and users" 
    task :add  => :environment do
      Student.last.add_to_mailing_list
    end
end
