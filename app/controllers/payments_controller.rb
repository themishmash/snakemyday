class PaymentsController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [ :webhook ] #skip authenticity as using webhook. otherwise screws things up due to external thing coming through. 

  #before_action :set_listing, only: [:success]
  def success
    
   @listing = Listing.find(params[:listingID])
   @user = User.find(params[:userID])
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

  private

  def set_listing #only use this way if use again and again
    listing_params = params[:listingID]
    @listing_id = Listing.find(listing_params) #this is object

  end 

  
end 