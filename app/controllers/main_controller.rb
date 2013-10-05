class MainController < ApplicationController
  respond_to :json, :html
  def index
    if params[:cid]
      @student = Student.find_by_id params[:cid]
    end
  end

  def create
    # binding.pry
    @student = Student.create(email: params[:email], first_name: params[:name])
    if @student
      response_message = @student.first_name
      mail = StudentMailer.new_student_notif(@student)
      if mail
        mail.deliver
      end
    end
    respond_with do |format|
      format.json{
        render json: {response: response_message }
      } 
    end
  end

  def show

  end

end
