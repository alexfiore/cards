class Deck < ActiveRecord::Base
  # Remember to create a migration!
  has_many :cards

  # write method for how to deal a random card from a deck
end
