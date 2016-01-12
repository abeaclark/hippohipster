enable :sessions

# view main player
get '/player' do
  @current_user = current_user
  erb :'player/index'
end
