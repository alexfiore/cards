class Card < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :deck
  has_many :guesses

  # to do, validations...
  
end
