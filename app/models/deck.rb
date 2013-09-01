class Deck < ActiveRecord::Base
  has_many :cards
  belongs_to :user
  
  validates :name, presence: true 

  # write method for how to deal a random card from a deck
  # def deal_next_card
  #   #pseudocode: 
  #   # given a deck, card, and game
  #   # the available cards are the cards that have 0 guesses

  #   available_cards.sample
  # end

end
