get '/' do 
  if current_user 
    redirect "/user_profile/#{@user.id}"
  else
    erb :index
  end
end

post '/login' do 
  @user = User.find_by_email(params[:user][:email])
  
  if @user.nil? 
    redirect '/'
  elsif User.authenticate(params[:user][:email], params[:user][:password])
    session[:id] = @user.id
    redirect "/user_profile/#{@user.id}"
  else
    redirect '/'
  end
end

before '/user_profile/:id' do
  unless current_user
    redirect '/'
  end
end

get '/user_profile/:id' do  #if current user is not log in then redirect them to '/'
  @decks = Deck.all
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


