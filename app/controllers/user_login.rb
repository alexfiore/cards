get '/' do 
  erb :index
end

post '/' do 
  @user = User.find_by_email(params[:user][:email])
  
  if @user.nil? 
    redirect '/'
  elsif User.authenticate(params[:user][:email], params[:user][:password])
    session[:id] = @user.id
    redirect "/user_profile/#{@user.id}"
  end
end

post '/signup' do
  @user = User.create(params[:user])
  if @user.save 
    session[:id] = @user.id
    redirect "/user_profile/#{@user.id}"
  else
    @errors = @user.errors.full_messages
    erb :index
  end
end

get '/logout' do
  session.clear
  redirect '/'
end

get '/user_profile/:id' do
  @decks = Deck.all
  erb :user_profile
end

