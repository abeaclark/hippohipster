enable :sessions

helpers do

  def user_by_id(id)
    User.find(id)
  end

  def current_user
    if session[:user_id]
      User.find(session[:user_id])
    end
  end

# NOT WORKING??
  # def current_user=(user)
  #   session[:user_id] = user.id
  # end

end
