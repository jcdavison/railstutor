class MainController < ApplicationController
  respond_to :json, :html

  def index
    @student = Student.new
  end

  def veterans
    @student = Student.new
  end

  def apply
  end

  def join
    message = "Greetings #{params[:first_name].capitalize},"
    unless Student.in_process(params) == "rejected"
      respond_with do |format|
        format.json{
          render json: {status: 200, email: params[:email], message: message } 
        } 
      end
    else
      respond_with do |format|
        format.json{
          render json: {status: 400} 
        } 
      end
    end
  end

  def create
    @amount = params[:payment].to_i 
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
      mail = StudentMailer.pmt_confirmation(@student)
      if mail
        mail.deliver
      end
    end
    respond_with do |format|
      format.json{
        render json: {message: "Congratulation #{@student.first_name}, transaction in amount of $#{@amount/100} complete, Welcome to RubyonRailsTutor.com, look for email from john@rubyonrailstutor.com", payment: @amount/100} 
      } 
    end
  end

  def show
  end

end
