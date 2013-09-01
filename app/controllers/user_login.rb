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
    redirect "/user_profile"
  else
    redirect '/'
  end
end

before '/user_profile' do
  unless current_user
    redirect '/'
  end
end

get '/user_profile' do  #if current user is not log in then redirect them to '/'
  @decks = Deck.all
  erb :user_profile
end

get '/user_profile/:id/history' do
  user = User.find(params[:id])

  @completed_rounds = []
  user.rounds.each do |round|
    if round.complete?
      @completed_rounds << round
    end
  end

  erb :history
end

get '/user_profile/:id/uncompleted_rounds' do
  user = User.find(params[:id])
  @uncompleted_rounds = []
  user.rounds.each do |round|
    unless round.complete?
      @uncompleted_rounds << round
    end
  end

  erb :uncompleted
end

post '/signup' do
  @user = User.new(params[:user])

  if @user.save 
    session[:id] = @user.id
    redirect "/user_profile"
  else
    @errors = @user.errors.full_messages
    erb :index
  end
end

get '/logout' do
  session.clear
  redirect '/'
end


