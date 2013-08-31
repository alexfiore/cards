class AddUserGuessToGuesses < ActiveRecord::Migration
  def change
    add_column :guesses, :user_guess, :string
  end
end
