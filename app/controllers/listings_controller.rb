class ListingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_listing, only: [ :show, :edit, :update, :destroy ] #this means we will do this action but only for these actions with the parameter associated with it. so delete info in show, edit, update, destroy as called set_listing does all this. 

  #this all matches in our routes

  def index 
      @listings = Listing.all #dealing with many
  end

  def show
      
  end

  def new
    @listing = Listing.new
    @listing.date_of_birth = "1971-01-01" #this will set default dob in view of new listing. 
  
  end

  def create
    # byebug #if type byebug - code will break here. sometimes if your raise is not working (like pry thing too)
    listing_params = params.require(:listing).permit(:title, :description, :breed_id, :sex, :price, :deposit, :city, :state, :date_of_birth, :diet, :picture) #this added so now after create new snake. look at schema to help make this. listing params - assigned to instance variable below.
    # @listing = Listing.new( listing_params ) 
    
    @listing = current_user.listings.create( listing_params )

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

end