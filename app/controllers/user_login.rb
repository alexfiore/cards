get '/' do 
  erb :login
end

get '/signup' do
  erb :signup
end

post '/' do
  
  @this_user = User.find_by_email(params[:email])
  
  if @this_user.nil? 
    redirect '/'
  elsif
    @this_user.password != params[:password]
    redirect '/'
  else
    session[:id] = @this_user.id
    erb :user_profile
  end

end

post '/signup' do
  @user = User.create(params)
  if @user.valid? 
    session[:id] = @user.id
    redirect '/user_profile/:id'
  else
    @errors = @user.errors.full_messages
    erb :signup
  end
end

post '/user_profile' do
  
end

