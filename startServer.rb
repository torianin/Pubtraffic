#-*- coding: utf-8 -*-

require 'sinatra'
require 'haml'
require 'coffee-script'
require 'sass'
require 'dataMapper'

get '/' do
  myfile = File.open("users.txt")
  card = myfile.readline(12)
  p3 = User.get(card)
  if(p3 != nil)
  	@user = p3.nick
  else
  	@user = 'Brak użytkownika w bazie'
  end
  haml :index
end

get '/app.js' do
  coffee :app
end

get '/style.css' do
   sass :stylesheet, :style => :expanded
end


