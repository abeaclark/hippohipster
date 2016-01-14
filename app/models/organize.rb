
module Organize
  include Player
  include Songkick
  include HTTParty

  # returns JSON object with multiple users
  def self.search_name(name)
    name = URI.escape(name)
    client = Player.initiate_basic_client
    client.get('/users', :q => name)
  end

  def self.search_name_return_first(name)
    self.search_name(name)[0]
  end

  # Parses the user_id from the user_uri
  def self.grab_user_id(user_url)
    user_url.gsub('https://api.soundcloud.com/users/', "")
  end

  def self.id_of_best_search_result(name)
    result = self.search_name_return_first(name)
    if result
      user_id = self.grab_user_id(result['uri'])
    else
      nil
    end
  end

  # Grabs the information from the users public profile
  def self.public_user_info_by_id(user_id)
    query_string = "http://api.soundcloud.com/users/#{user_id}?client_id=#{client_id}"
    response = HTTParty.get(query_string)
    JSON.parse(response.body)
  end

  # Grabs the tracks of a user
  def self.tracks_by_user_id(user_id)
    query_string = "http://api.soundcloud.com/users/#{user_id}/tracks/?client_id=#{client_id}"
    response = HTTParty.get(query_string)
    JSON.parse(response.body)
  end

  # Combines all of the tags into one array.
  # Separates each word into a separate index
  # Returns the array of tags
  def self.aggregate_user_tags(user_id)
    tracks = self.tracks_by_user_id(user_id)
    tags = []
    tracks.each do |track|
      current_tags = track['tag_list'].gsub(/[^\w\s]/,"").split(" ")
      p "current_tags: #{current_tags}"
      tags += current_tags
    end
    tags
  end

  def self.create_performers(metro_area_id)
    # get pull from SC
    event_list = Songkick.upcoming_events(metro_area_id)["resultsPage"]["results"]["event"]
    details = Songkick.extract_user_details_from_events(event_list)
    # iterate through each performer
    details.each do |id, name|
      performer = Performer.find_by(sk_id: id.to_s)
      if performer
      ## if in database, do nothing
        puts'Already present'
      else
        ### get SK id
        sk_id = id
        ### get SC id
        sc_id = self.id_of_best_search_result(name)
        ### make the record
        if sc_id
          performer = Performer.create({
                            sk_id: sk_id,
                            sc_id: sc_id
                          })
          ### determine tags
          sc_tags = self.aggregate_user_tags(sc_id)
          performer.collate_tags_with_db(sc_tags)
        end
      end
    end
  end

  ## input array of tag values and array of performer objects)
  ## output array of performers who match the criteria
  def self.performers_who_match_tags(array_of_tag_values, local_performers)
    tags = find_tags_by_value(array_of_tag_values)
    targeted_performers = []
    local_performers.each do |performer|
      targeted_performers << performer if (performer.tags && tags]
    end
    targeted_performers
  end

  private
  def find_tags_by_value(array_of_tag_values)
    tags = []
    array_of_tag_values.each do |value|
      tags << Tag.find_by(value: value)
    end
    tags
  end

end
