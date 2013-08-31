get '/' do 
  erb :login
end

get '/signup' do
  erb :signup
end

post '/' do
  
  @user = User.find_by_email(params[:email])
  
  if @user.nil? 
    redirect '/'
  elsif User.authenticate(params[:email], params[:password])
    session[:id] = @user.id
    redirect "/user_profile/#{@user.id}"
  end
end

post '/signup' do
  @user = User.create(params[:user])
  if @user.valid? 
    session[:id] = @user.id
    redirect '/user_profile/:id'
  else
    @errors = @user.errors.full_messages
    erb :signup
  end
end

get '/logout' do
  session[:id] = nil
  redirect '/'
end

get '/user_profile/:id' do

  erb :user_profile
end

