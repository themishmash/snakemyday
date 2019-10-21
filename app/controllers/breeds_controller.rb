class BreedsController < ApplicationController
  before_action :set_breed, only: [ :show, :edit, :update, :destroy ]

  def index
    @breeds = Breed.all
  end 

  def show
  end 

  def new
    @breed = Breed.new
    @breed.created_at = "2019-01-01"
  end 

  def create
    breed_params = params.require(:breed).permit(:name, :created_at, :updated_at)
    @breed = Breed.new( breed_params )

    

    if @breed.save

    redirect_to @breed
    else
      render :new
    end 

  end 

  def edit
  end

  def update
    breed_params = params.require(:breed).permit(:name, :created_at, :updated_at)
    @breed.update(breed_params)
  end 

  def destroy
    @breed.destroy
    redirect_to breeds_path
  end 

  private

  def set_breed
    id = params[:id]
    @breed = Breed.find(id)
  end 

end 