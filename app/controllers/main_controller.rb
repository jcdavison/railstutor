class MainController < ApplicationController
  respond_to :json, :html
  def index
    if params[:cid]
      @student = Student.find_by_id params[:cid]
    end
  end

  def create
    @student = Student.create(email: params[:email], first_name: params[:name])

    binding.pry
    begin
      customer = Stripe::Customer.create(
        email: params[:email],
        card: params[:stripe][:id]
      )
      @amount = params[:amount]
      charge = Stripe::Charge.create(
          :customer    => customer.id,
          :amount      => @amount,
          :description => @student.email,
          :currency    => 'usd'
      )
      rescue Stripe::CardError => e
        render json: {response: "stripe error#{e.message}"}
    end

    if @student
      response_message = @student.first_name
      mail = StudentMailer.new_student_notif(@student)
      if mail
        mail.deliver
      end
    end
    respond_with do |format|
      format.json{
        render json: {response: {message: "complete", amount: @amount} }
      } 
    end
  end

  def show

  end

end
