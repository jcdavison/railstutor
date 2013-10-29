class Student < ActiveRecord::Base
  attr_accessible :email, :first_name, :info, :last_name, :paid, :phone, :linkedin, :github, :intro_video
end
