get '/deck/:deck_id/edit' do 
  @deck = Deck.find(params[:deck_id])
  erb :edit_deck
end

put '/deck/:deck_id' do 
  deck = Deck.find(params[:deck_id])
  deck.update_attributes(name: params[:deck_name])
  redirect '/'
end

delete '/deck/:deck_id' do
  Deck.find(params[:deck_id]).destroy
  redirect '/'
end

