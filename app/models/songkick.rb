require 'uri'
require 'json'


def api_key
  ENV['SK_API_KEY']
end

module Songkick
  include HTTParty

  def self.location_search(params={})
    location = URI.escape(params[:location])
    query_string = "http://api.songkick.com/api/3.0/search/locations.json?query=#{location}&apikey=#{api_key}"
    response = HTTParty.get(query_string)
    JSON.parse(response.body)
  end

  def self.location_based_on_ip
    query_string = "http://api.songkick.com/api/3.0/search/locations.json?location=clientip&apikey=#{api_key}"
    response = HTTParty.get(query_string)
    JSON.parse(response.body)
  end

  def self.upcoming_events(metro_area_id)
    query_string = "http://api.songkick.com/api/3.0/metro_areas/#{metro_area_id}/calendar.json?apikey=#{api_key}"
    response = HTTParty.get(query_string)
    JSON.parse(response.body)
  end

  def self.extract_user_details_from_events(events_list)
    details = {}
    events_list.each do |event|
      id = event["performance"][0]["artist"]['id']
      name = event["performance"][0]["displayName"]
      details[id] = name
    end
    details
  end


end

# 26330
