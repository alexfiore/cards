class Guess < ActiveRecord::Base

  belongs_to :round
  belongs_to :card

  def check_if_correct(guess)
    self.right_wrong = guess == self.card.answer 
  end

  def correct?
    user_guess == self.card.answer
  end

end

