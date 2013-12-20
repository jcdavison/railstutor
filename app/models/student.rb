class Student < ActiveRecord::Base
  attr_accessible :email, :first_name, :info, :last_name, :paid, :phone, :linkedin, :github, :intro_video

  before_create :valid_email?

  def full_name
    return unless first_name && last_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def add_to_mailing_list
    return unless self.email
    email = self.email
    first = self.first_name || "Hacker"
    last = self.last_name || "Hacker"
    full_name = self.full_name || "Hacker"
    vars = { first: first, last: last }
    vars = vars.to_json
    begin
      response = RestClient.post("https://api:#{RAILSTUTOR_MAILGUN}@api.mailgun.net/v2/lists/hackers@rubyonrailstutor.com/members",
                    :subscribed => true,
                    :address => email,
                    :name => full_name,
                    :description  => 'hacker',
                    :upsert  =>  'yes',
                    :vars  => vars)
    rescue => e
      return false
    end
    return true
  end

  def valid_email?
    return false unless self.email
    email = CGI::escape self.email
    address = "address=#{email}"
    begin
      response = RestClient.get "https://api:#{RAILSTUTOR_PUBLIC_MAILGUN}@api.mailgun.net/v2/address/validate?#{address}"
    rescue => e
      return e.inspect
    end
    response = JSON.parse(response)
    if response["is_valid"] == true
      return true
    else
      return false
    end
  end

  def self.remove_invalid
    Student.all.each do |student|
      if student.valid_email? == false
        student.destroy
      end
    end
  end

end
