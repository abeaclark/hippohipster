get '/test' do
  @search_parameter = 'Jasmine Jordan'
  @result = Organize.search_name_return_first(@search_parameter)
  @user_id = Organize.grab_user_id(@result['uri'])
  @extended_result = Organize.public_user_info_by_id(@user_id)
  @tracks = Organize.tracks_by_user_id(@user_id)
  erb :'tests/search'
end
