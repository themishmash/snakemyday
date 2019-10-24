class ListingsController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :set_listing, only: [:show] 
  before_action :set_user_listing, only: [ :edit, :update, :destroy ] #this means we will do this action but only for these actions with the parameter associated with it. so delete info in show, edit, update, destroy as called set_listing does all this.
 

  #this all matches in our routes

  def index 
      @listings = Listing.all #dealing with many
      #@listings = current_user.listings
  end

  def show #line items for stripe. Line items is an array. 
      session = Stripe::Checkout::Session.create(
        payment_method_types: [ 'card'],
        customer_email: current_user.email, #set up by devise
        line_items: [{
          name: @listing.title, #remember when come into show - it will set listing for current user
          description: @listing.description, 
          amount: @listing.deposit * 100, #stripe works in cents so make sure get cents value
          currency: 'aud', 
          quantity: 1
        }],

        payment_intent_data: {
          metadata: {
            user_id: current_user.id, 
            listing_id: @listing.id
          }
        },

        #where we want it to go when succeed. Root URL supplments your website and action want to take when success. 

        success_url: "#{root_url}payments/success?userID=#{current_user.id}&listingID=#{@listing.id}", 
        cancel_url: "#{root_url}listings"
    )

    @session_id = session.id
  end

  def new
    @listing = Listing.new
    @listing.date_of_birth = "1971-01-01" #this will set default dob in view of new listing. 
  
  end

  def create
    # byebug #if type byebug - code will break here. sometimes if your raise is not working (like pry thing too)
    listing_params = params.require(:listing).permit(:title, :description, :breed_id, :sex, :price, :deposit, :city, :state, :date_of_birth, :diet, :picture) #this added so now after create new snake. look at schema to help make this. listing params - assigned to instance variable below.
    # @listing = Listing.new( listing_params ) 
    
    @listing = current_user.listings.new( listing_params )

    @listing.traits << Trait.find(params[:listing][:trait_id])
    @listing.save

    if @listing.save 
    #this saves to database. Data that is sent to controller - passed to instance variable and then saved. 
  
    redirect_to @listing #this creates another error. need new params to set instance variable. see above now listing_params = blah blah blah
    else 
      render :new #has to be symbol new. 
    end 
      #finish logic for creating a record
  end

  def edit
      
  end

  def update
    listing_params = params.require(:listing).permit(:title, :description, :breed_id, :sex, :price, :deposit, :city, :state, :date_of_birth, :diet, :picture, :trait)
    
    if @listing.update( listing_params )
      

    redirect_to @listing
    else 
      render :edit
    end 
      #finsih logic for updating the record
  end

  def destroy

    @listing.destroy
    redirect_to listings_path
     
      #finish logic for deleting the record
  end

  private #this means the actions below will not available outside this controller. everything above that is available to the world. 


  def set_listing #part of the before action. ONly should be called within this controller and no where else. so will make it private. 
    id = params[:id]
    @listing = Listing.find(id)
  end 

  def listing_params
    params.require(:listing).permit(:title, :description, :breed_id, :sex, :price, :deposit, :city, :state, :date_of_birth, :diet, :picture, :trait)
  end 

  def set_user_listing
    id = params[:id]
    @listing = current_user.listings.find_by_id( id )

    if @listing == nil
      redirect_to listings_path
    else
      if @listing.deposit == nil
        @listing.deposit = 1
      end 
    end 
  end 

end