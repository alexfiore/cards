get '/deck/:deck_id/cards' do 
  @all_cards = Deck.find(params[:deck_id]).cards 
  erb :cards_show
end

get '/deck/:deck_id/cards/:card_id' do 
  @deck = Deck.find(params[:deck_id])
  @card = Card.find(params[:card_id])
  erb :edit_card
end

put '/deck/:deck_id/cards/:card_id' do 
  card = Card.find(params[:card_id])
  card.prompt = params[:card_prompt]
  card.answer = params[:card_answer]
  card.save
  redirect "/deck/#{card.deck_id}/cards"
end

delete '/deck/:deck_id/cards/:card_id' do
  deck_id = Card.find(params[:card_id]).deck_id
  Card.find(params[:card_id]).destroy
  redirect "/deck/#{deck_id}/cards"
end


