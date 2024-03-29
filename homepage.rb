require "bundler"
require 'sinatra'
require 'httparty'
require 'sass'
require 'newrelic_rpm'

class WebApp < Sinatra::Base

  # functions
  def get_park
    current_park = nil
    parks = HTTParty.get("http://mhpmproperties.herokuapp.com/api/parks") 
    puts parks 
    parks.each_with_index do |park, index|
      if park["name"].split(" ").first.downcase == "orange"
        current_park = parks[index]
        puts current_park["name"] + " is the current_park"
      else 
        puts "no current park"
      end
    end
    return current_park
  end

  def get_homes
    orange_id = 1
    homes = HTTParty.get("http://mhpmproperties.herokuapp.com/api/homes")
    puts homes
    homes.each {|h|
      if h['park_id'] != orange_id
        homes.delete(h)
      end
    }
    return homes 
  end

  before do
    park = get_park
    @phone = park["phone_number"]
  end

  # routes
  get '/' do
    current_park = get_park
    erb :index, locals: { current_park: current_park } 
  end

  get '/homes' do
    homes = get_homes
    erb :homes, locals: { homes: homes } 
  end 

  get '/gallery' do
    current_park = get_park
    erb :gallery, locals: { current_park: current_park } 
  end 

  get '/contact' do
    current_park = get_park
    erb :contact, locals: { current_park: current_park } 
  end 

  get "/main.css" do
    scss :main
  end

  get "/homes.css" do
    scss :homes
  end

  get "/normalize.css" do
    scss :normalize
  end

# get '/*' do
#   redirect('/')
# end

end

WebApp.run!

