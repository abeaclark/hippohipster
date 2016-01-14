enable :sessions

helpers do

  def user_by_id(id)
    User.find(id)
  end

  def current_user
    if session[:user_id]
     @current_user = User.find(session[:user_id])
    end
  end

  def current_user=(user)
    session[:user_id] = user.id
  end

  def set_error(text)
    session[:error] = text
  end

 def logout
   session.clear
 end

 def show_errors
   if session[:error]
     @error = session[:error]
     session[:error] = nil
   end
 end

 def set_return_cookie
   session[:referrer] = request.referrer
   p request.referrer
 end

 def redirect_address_if_exists
   if session[:referrer]
     address = session[:referrer]
     session[:referrer] = nil
     set_error('Thanks for logging in!')
     return address
   else
     nil
   end
 end

end
