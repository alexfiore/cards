class Round < ActiveRecord::Base
  belongs_to :user
  has_many :guesses
  belongs_to :deck

  def deal_card
    
    # we want to deal a random card from this round's deck
    # the card should have nil user_guess...

    # selects the guess objects associated with 
    # the cards that are in 
    # my current round's deck

    # self.guesses
    # has_many :dealt_cards, :through => :guesses, :class => "Card", :source => :card
    current_round_guesses = Guess.where(card_id: [self.deck.cards.map(&:id)], round_id: self.id)
    already_dealt_cards = Card.where(id: [current_round_guesses.map(&:card_id)])
    unguessed_cards = self.deck.cards - already_dealt_cards
    unguessed_cards.sample 

  end

  def complete?
    deal_card.nil?
  end

end
