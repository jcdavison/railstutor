class StudentMailer < ActionMailer::Base
  JD = "john@rubyonrailstutor.com"
  default from: JD 
  
  def new_student_notif(student)
    @student = student
    mail(to: @student.email, subject: "Welcome to RubyonRailsTutor.com",  reply_to: JD, bcc: JD)
  end
end
