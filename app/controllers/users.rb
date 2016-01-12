enable :sessions

# view new user form
get '/users/new' do
  @current_user = current_user
  erb :'users/new'
end

put '/users/:id' do
  current_user
  @current_user.update({
    username: params[:username],
    first_name: params[:first_name],
    last_name: params[:last_name],
    email: params[:email],
    password: params[:password]
    })

  redirect '/player'
end


# view user by ID
get '/users/:id' do
  erb :'users/edit'
end


