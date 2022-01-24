require 'httparty'

class TransactionsController < ApplicationController

  def paystack 
    secret_test_keys = "sk_test_87f4c34f9d770d54fcca841229a5566e23256172"
    @order = Order.find_by(ref_no: params[:ref])
    amount = @order.price
    ref = @order.ref_no

    response = HTTParty.get("https://api.paystack.co/transaction/verify/#{ref}", 
                  # headers: { "Authorization"=> "Bearer #{Rails.application.credentials.dig(:paystack, :secret_key)}",
                  headers: { "Authorization"=> "Bearer #{secret_test_keys}",
                  "content-type" => "application/json"})

    paid = response['data']['amount']/100
    status = response['data']['status']

    if paid == amount && status == 'success'
      @order.update!(status: true, country: @country, payment_method: "PAYSTACK" )
      render json: {message: "Payment successful"}
    else
      render json: {message: "Payment was unsuccessful"}, status: :unprocessable_entity
    end

  end


  
end
