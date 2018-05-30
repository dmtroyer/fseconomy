namespace :fse do
  desc 'Retrieve Aircraft Models from FSEconomy'
  task :retrieve_aircraft_models do
    uri = URI.parse("http://server.fseconomy.net/data?userkey=#{ENV['FSE_ACCESS_KEY']}&format=xml&query=aircraft&search=configs")
    response = Net::HTTP.get_response(uri)
    puts response.body
  end
end
