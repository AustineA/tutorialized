class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  
    def index
      @orders = Order.all.order(created_at: :desc)
    end
  
    def show
    end
  
    def create
      @course = Course.find_by_slug(params[:slug])
      @order = @course.orders.build(price: @course.price, title: @course.title, ref_no: "LTC-#{rand(36**10).to_s(36).upcase}")
      @order.user = current_user
      @order.status =  true if !@course.price.positive?    
  
      if @order.save
        if params[:stripe].present? && params[:stripe] == "true" 
          stripe @order
        else
        render json: {  
          message: 'success',  
          reference: @order.ref_no, 
          email: @order.user.email, 
          firstname: @order.user.f_name,
          lastname: @order.user.l_name,
          }, status: :created
        end
      else
        render json: @order.errors, status: :unprocessable_entity
      end
    end
  
  
    def update
        if @order.update(order_params)
          render :show
        else
          render json: @order.errors, status: :unprocessable_entity
        end
    end
  
  
    def destroy
      @order.destroy
    end
  
    private
    def set_order
      @order = Order.find(params[:id])
    end



    def stripe order
      Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret_key)
      price = ( BigDecimal(order.price) / BigDecimal(360) ).to_f.ceil
      amount = price*100
  
      intent = Stripe::PaymentIntent.create({
        amount: amount,
        currency: 'usd',
        receipt_email: order.user.email,
        metadata: {
          ref_no: order.ref_no,
          country: @country
        }
      })

  
      render json: {clientSecret: intent['client_secret'], email: order.user.email, name: "#{order.user.f_name} #{order.user.l_name}"}
    end
  
end
