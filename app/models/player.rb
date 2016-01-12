module Player
  def client_id
    ENV['CLIENT_ID']
  end

  def client_secret
    ENV['CLIENT_SECRET']
  end

  def self.initiate_basic_client
    Soundcloud.new(:client_id => client_id)
  end

  def self.initiate_client_with_secret
    Soundcloud.new({
      :client_id => client_id,
      :client_secret => client_secret
      })
  end

  def self.initiate_client_access_token(access_token)
    Soundcloud.new(:access_token => access_token)
  end

  def self.initiate_client_with_secret_and_redirect(redirect_uri)
    SoundCloud.new({:client_id => client_id,
                    :client_secret => client_secret,
                    :redirect_uri => redirect_uri
                    })
  end

  def self.search_name()

  end


end
