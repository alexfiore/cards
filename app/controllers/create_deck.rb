get '/deck' do
  erb :create_deck
end

post '/deck' do
  deck = Deck.new(name: params[:deck_name])

  if deck.save
    redirect "/deck/#{deck.id}"
  else
    @errors = deck.errors.full_messages
    "Deal with errors"
  end
end

get '/deck/:deck_id' do
  @deck_id = params[:deck_id]
  erb :add_cards
end

post '/card' do 
  deck = Deck.find(params[:deck_id])
  deck.cards.create(prompt: params[:prompt], answer: params[:answer])
  redirect "/deck/#{deck.id}"
end

