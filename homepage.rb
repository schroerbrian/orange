require "bundler"
require 'sinatra'
require 'httparty'
require 'sass'
# functions
# def get_park
#   current_park = nil
#   parks = HTTParty.get("http://mhpmproperties.herokuapp.com/api/parks")
  
#   parks.each_with_index do |park, index|
#     if park["name"].split(" ").first.downcase == File.basename(Dir.getwd).downcase
#       current_park = parks[index]
#     end
#   end
#   return current_park
# end 

# routes
get '/' do
  current_park = nil
  parks = HTTParty.get("http://mhpmproperties.herokuapp.com/api/parks") 
  puts parks 
  parks.each_with_index do |park, index|
    if park["name"].split(" ").first.downcase == File.basename(Dir.getwd).downcase
      current_park = parks[index]
      puts current_park["name"] + " is the current_park"
    else 
      puts "no current park"
    end
  end
  current_park = { "name" => "park" }
  erb :index, locals: { current_park: current_park } 
end

get "/main.css" do
  scss :main
end


get "/normalize.css" do
  scss :normalize
end

# get '/*' do
#   redirect('/')
# end