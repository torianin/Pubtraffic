require 'sinatra'
require 'haml'
require 'coffee-script'
require 'sass'



get '/' do
  myfile = File.open("users.txt")
  @user = myfile.readline
  haml :index
end

get '/app.js' do
  coffee :app
end

get '/style.css' do
   sass :stylesheet, :style => :expanded
end


