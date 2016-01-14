def client_id
  ENV['CLIENT_ID']
end

def client_secret
  ENV['CLIENT_SECRET']
end

get '/oauth' do
  current_user
  redirect '/player' if @current_user
  client = Player.initiate_client_with_secret_and_redirect('http://localhost:9393/callback')
  redirect client.authorize_url()

end

get '/callback' do
  client = Player.initiate_client_with_secret_and_redirect('http://localhost:9393/callback')

  code = params[:code]
  access_token = client.exchange_token(:code => code)[:access_token]

  client = Player.initiate_client_access_token(access_token)

  # make an authenticated call
  begin
    current_user = client.get('/me')
  rescue Soundcloud::ResponseError => e
    puts "ERROR: #{e.message}, Status Code: #{e.response.code}"
  end

  user = User.create({
      first_name: current_user.first_name,
      last_name: current_user.last_name,
      username: current_user.username,
      soundcloud_token: access_token,
      avatar_link: current_user.avatar_url,
      soundcloud_uri: current_user.uri
    })

  current_user = user

  session[:user_id] = user.id

  redirect '/users/new'
end
