before do 
  erb :index unless logged_in? 
end


get '/' do 
  if current_user 
    redirect "/user_profile"
  else
    erb :index
  end
end

post '/login' do 
  @user = User.find_by_email(params[:user][:email])
  
  if User.authenticate(params[:user][:email], params[:user][:password])
    session[:id] = @user.id
    redirect "/user_profile"
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

before '/user_profile' do
  unless current_user
    redirect '/'
  end
end

get '/user_profile' do  #if current user is not log in then redirect them to '/'
  @decks = Deck.where(user_id: nil) + Deck.where(user_id: current_user.id)
  erb :user_profile
end

get '/user_profile/history' do
  @completed_rounds = []
  current_user.rounds.each do |round|
    if round.complete?
      @completed_rounds << round
    end
  end

  erb :history
end

get '/user_profile/uncompleted_rounds' do
  @uncompleted_rounds = []
  current_user.rounds.each do |round|
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
