class Student < ActiveRecord::Base
  attr_accessible :email, :first_name, :info, :last_name, :paid, :phone, :linkedin, :github, :intro_video

  validates_presence_of :first_name, :last_name, :email
  validates_uniqueness_of :email
  before_create :validate_email_and_subscribe

  def self.in_process! params
    student = self.find_by_email params[:email]
    if student
      student.update_attributes email: params[:email], first_name: params[:first_name], last_name: params[:last_name]
      return false
    else
      student = self.create( first_name: params[:first_name], 
        last_name: params[:last_name], email: params[:email])
      #mailer calls not tested
      mail = StudentMailer.new_student_notif(student)
      if mail
        mail.deliver
      end
      return true
    end
  end

  def full_name
    return unless first_name && last_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def self.populate_list
    Student.all.each {|student| student.add_to_mailing_list }
  end

  def validate_email_and_subscribe
    if self.valid_email?
      self.add_to_mailing_list
    else
      return false
    end
  end

  def add_to_mailing_list
    return unless self.email
    email = self.email
    first = self.first_name.capitalize || "Hacker"
    last = self.last_name.capitalize || "Hacker"
    full_name = self.full_name || "Hacker"
    vars = { first: first, last: last }
    vars = vars.to_json
    begin
      response = RestClient.post("https://api:#{RAILSTUTOR_MAILGUN}@api.mailgun.net/v2/lists/#{Rails.configuration.mailing_list}@rubyonrailstutor.com/members",
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
    #stubbing this method to return true in specs
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

  def self.remove_invalid!
    Student.all.each do |student|
      if student.valid_email? == false
        student.destroy
      end
    end
  end

end
