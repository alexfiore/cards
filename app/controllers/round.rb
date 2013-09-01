post '/round' do
  selected_deck = Deck.find(params[:deck_id])

  round = current_user.rounds.create(completion_status: false, deck_id: selected_deck.id)

  redirect "/round/#{round.id}"
end

get '/round/:round_id' do

  @round = Round.find(params[:round_id])
  @card = @round.deal_card

  if @round.complete?
    redirect "/round/#{params[:round_id]}/statistics"
  end
 
  erb :round_show
end

get '/round/:round_id/statistics' do
  @round = Round.find(params[:round_id])

  @correct, @incorrect, @round_percent = @round.statistics

  erb :game_statistics
end


post '/round/:round_id/guess' do
  # set a variable that checks if guess is correct or not...
  user_guess = params[:user_input]
  current_card = Card.find(params[:card_id])
  current_round = Round.find(params[:round_id])

  @guess = Guess.new(card: current_card, 
                    round: current_round,
                    user_guess: user_guess)  

  @guess.save

  # show feedback that has a link for "give me the next card"
  redirect "/round/#{params[:round_id]}/guess/#{@guess.id}"
end

get '/round/:round_id/guess/:guess_id' do

  @round = Round.find(params[:round_id])
  @guess = Guess.find(params[:guess_id])


  erb :guess_show
end

post '/next' do 
  # handle the input/params we get from feedback
  # set @card variable and then pipe that into 
  # the :play view 

  @card = Card.find(params[:card_id])  
  erb :play  
end
