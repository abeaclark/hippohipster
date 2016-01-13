get '/events' do
  location_request = Songkick.location_based_on_ip
  @metro_area = location_request["resultsPage"]["results"]["location"][0]["metroArea"]["displayName"]
  location_id = location_request["resultsPage"]["results"]["location"][0]["metroArea"]["id"]
  @upcoming_events = Songkick.upcoming_events(location_id)["resultsPage"]["results"]["event"]
  erb :'events/index'
end
