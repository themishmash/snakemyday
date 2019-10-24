class PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [ :webhook ] #skip authenticity as using webhook. otherwise screws things up due to external thing coming through. 
  def success

  end 

  def webhook
    payment_id = params[:data][:object][:payment_intent]
    payment = Stripe::PaymentIntent.retrieve( payment_id )

    listing_id = payment.metadata.listing_id
    user_id=payment.metadata.user_id
    p "listing id =" + listing_id
    p "user id =" + user_id
    
    status 200
  end 

  
end 