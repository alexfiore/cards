get '/deck/:deck_id' do
  selected_deck = Deck.find(params[:deck_id])

  @round = current_user.rounds.create(completion_status: false, deck_id: selected_deck.id)
  session[:round_id] = @round.id

  @card = @round.deck.cards.first

  erb :play
end

post '/play' do
  # set a variable that checks if guess is correct or not...
  user_guess = params[:user_input]
  current_card = Card.find(params[:card_id])
  current_round = Round.find(session[:round_id])

  @guess = Guess.new(card: current_card, 
                    round: current_round,
                    user_guess: user_guess)  

  @guess.check_if_correct(user_guess)

  @guess.save

  # set card variable (as the next unanswered card)
  @card = current_round.deck.deal_next_card 

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
