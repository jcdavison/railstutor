class Student < ActiveRecord::Base
  attr_accessible :email, :first_name, :info, :last_name, :paid, :phone, :linkedin, :github, :intro_video, :applied, :twitter

  validates_presence_of :first_name, :last_name, :email
  validates_uniqueness_of :email
  before_create :validate_email_and_subscribe

  def self.in_process params
    # this method is disgusting but I don't have time today to deal with it
    student = self.find_by_email params[:email]
    if params[:applied] == "true" && ! student
      student = self.create( first_name: params[:first_name], 
        last_name: params[:last_name], email: params[:email], 
        linkedin: params[:linkedin], github: params[:github],
        intro_video: params[:video], applied: true)
      return "applied"
    elsif params[:applied] == "true" && student
      student.update_attributes( first_name: params[:first_name], 
        last_name: params[:last_name], email: params[:email],
        linkedin: params[:linkedin], github: params[:github],
        intro_video: params[:video], applied: true)
        Student.route_welcome_message student
      return "applied"
    elsif params[:applied] == "false" && ! student
      student = self.new( first_name: params[:first_name], 
        last_name: params[:last_name], email: params[:email], applied: false, twitter: params[:twitter])
      if student.save
        return "created"
      else
        return "rejected"
      end
    else params[:applied] == "false" && student
      return "rejected"
    end
  end

  def self.route_welcome_message student
    if student.applied == true
      mail = StudentMailer.new_application_notif student
      mail.deliver
    elsif student.applied == false
      mail = StudentMailer.new_community_welcome student
      mail.deliver
    end
  end

  def full_name
    return unless first_name && last_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def update_extended! params
    self.update_attributes linkedin: params[:linkedin], github: params[:github], intro_video: params[:video], phone: params[:phone]
    self.applied!
  end

  def applied!
    self.update_attributes applied: true
  end

  def self.populate_list
    Student.all.each {|student| student.add_to_mailing_list }
  end

  def validate_email_and_subscribe
    if self.valid_email?
      self.add_to_mailing_list
      Student.route_welcome_message self
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
