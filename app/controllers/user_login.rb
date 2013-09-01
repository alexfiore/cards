get '/' do 
  if current_user 
    redirect "/user_profile/#{@user.id}"
  else
    erb :index
  end
end

post '/login' do 
  @user = User.find_by_email(params[:user][:email])
  
  if User.authenticate(params[:user][:email], params[:user][:password])
    session[:id] = @user.id
    redirect "/user_profile/#{@user.id}"
  elsif @user.nil? 
    @errors = []
    @errors << "Unable to find user with that email..."
    erb :index
  else
    @errors = []
    @errors << "We could not authenticate you."
    erb :index
  end
end

before '/user_profile/:id' do
  unless current_user
    redirect '/'
  end
end

get '/user_profile/:id' do  #if current user is not log in then redirect them to '/'
  @decks = Deck.where(user_id: nil) + Deck.where(user_id: user.id)
  erb :user_profile
end

post '/signup' do
  @user = User.new(params[:user])

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
