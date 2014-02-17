require 'sinatra'
require 'rubygems'
require 'compass'
require 'json'
require 'httparty'
# require 'sinatra/cache'

get '/' do
  parks = HTTParty.get("http://mhpmproperties.herokuapp.com/api/parks")
  # parks = JSON.parse response.body
  puts parks 
  erb :index, locals: { parks: parks } 
end


# get '/:username/:id' do
#   begin 
#     response = HTTParty.get("https://api.momentage.com/api/v2/moments/#{params[:id]}?auth_token=r3ybiesKBnwx9MHyoskm")
#     moment = JSON.parse response.body
#     puts moment
#     haml :show, :locals => { :moment => moment }
#   rescue
#     haml :show_rescue 
#   end  
# end