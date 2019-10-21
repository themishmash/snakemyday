class Listing < ApplicationRecord
  belongs_to :breed
  enum sex: { female: 0, male: 1 } #this is called enumeration


  validates :title, :sex, :price, :breed, :city, presence: true #all these fields need to be there. Took description out and put below

  #validates :title, presence: true #test this by going to rails console

  validates :state, inclusion: { in: %w(VIC NSW WA TAS NT ACT QLD SA),
          message: "%{value} is not a valid state"}

  validates :description, presence: true,
            length: { minimum: 10 }

  validates_numericality_of :deposit, :only_integer => true, :less_than_or_equal_to => :price

  has_one_attached :picture
  
  

  
end

