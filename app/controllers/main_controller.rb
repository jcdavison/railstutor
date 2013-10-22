class MainController < ApplicationController
  respond_to :json, :html
  def index
    if params[:cid]
      @student = Student.find_by_id params[:cid]
    end
  end

  def create
    @amount = 50000
    @student = Student.create(email: params[:email], first_name: params[:first_name], last_name: params[:last_name], info: params[:pmt_token])

    begin
      charge = Stripe::Charge.create(
          :card    => params[:pmt_token],
          :amount      => @amount,
          :description => @student.email,
          :currency    => 'usd'
      )
      rescue Stripe::CardError => e
        respond_with do |format|
          format.json {
            render json: {error: "stripe error#{e.message}"}
          }
        end
    end

    if @student
      @student.update_attributes(paid: true)
      mail = StudentMailer.new_student_notif(@student)
      if mail
        mail.deliver
      end
    end
    respond_with do |format|
      format.json{
        render json: {message: "Congratulation #{@student.first_name}, transaction in amount of $500 complete, Welcome to RubyonRailsTutor.com, look for email from john@rubyonrailstutor.com"} 
      } 
    end
  end

  def show

  end

end
