#-*- coding: utf-8 -*-

require 'sinatra'
require 'haml'
require 'coffee-script'
require 'sass'

get '/' do
  haml :index
end

get '/app.js' do
  coffee :app
end

get '/contact' do
	haml :contact
end

get '/css/style.css' do
   sass :stylesheet, :style => :expanded
end


