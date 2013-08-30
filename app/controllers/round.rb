### routes for "a user can view all available decks" ###

## WILL NEED TO CHANGE ONCE LOGIN IS IMPLEMENTED
get '/' do

  ### STUB ###
  current_user = User.first 
  ### STUB ###  

  @decks = Deck.all
  erb :available_decks
end

get '/deck/:deck_id' do
  current_user = User.first
  current_deck = Deck.find(params[:deck_id])

  @round = current_user.rounds.create(completion_status: false, deck_id: current_deck.id)

  erb :play
end

get'/deck/:deck_id/card/:card_id' do

end
