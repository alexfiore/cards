class Guess < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :round
  belongs_to :card

  # write method for how to check if a guess is correct.
end

