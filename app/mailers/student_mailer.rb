class StudentMailer < ActionMailer::Base
  JD = "john@rubyonrailstutor.com"
  default from: JD 
  
  def new_community_welcome student
    @student = student
    mail to: @student.email, subject: "Welcome to RubyonRailsTutor.com",  reply_to: JD, bcc: JD
  end

  def new_lead student
    @student = student
    mail to: JD, subject: "rubyonrailstutor new lead"
  end

  def new_application_notif student
    @student = student
    mail to: @student.email, subject: "RubyonRailstutor.com application received",  reply_to: JD, bcc: JD
  end

  def pmt_confirmation student
    @student = student
    mail to: @student.email, subject: "RubyonRailstutor.com PMT Confirmation",  reply_to: JD, bcc: JD
  end
end
