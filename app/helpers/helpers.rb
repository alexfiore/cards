helpers do 
  def current_user
    #returns current user or nil
    #current user is someone we can find based on what's inside your session
    @user ||= User.find(session[:id]) if session[:id]
  end

  def current_round
    @round ||= Round.find
  end

end
