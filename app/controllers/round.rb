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
  @card = @round.deck.cards.where(id: 1).first

  erb :play
end

post '/play' do
  # set a variable that checks if guess is correct or not...
  @check = params[:user_input] == params[:answer]

  # set card variable (as the next unanswered card)
  @card = Card.find(params[:card_id]).next

  # show feedback that has a link for "give me the next card"
  erb :feedback
end

post '/next' do 
  # handle the input/params we get from feedback
  # set @card variable and then pipe that into 
  # the :play view 

  @card = Card.find(params[:card_id])  
  erb :play  
end
