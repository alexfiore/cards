class Card < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :deck
  has_many :guesses

  # to do, validations...
  
  def next
    # for self (i.e. a card object), return the next card object.
    current_id = self.id
    next_id = self.id + 1
    Card.find(next_id)
  end

end
