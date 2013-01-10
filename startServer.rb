#-*- coding: utf-8 -*-

require 'sinatra'
require 'haml'
require 'coffee-script'
require 'sass'
require '/Users/Robert/Documents/Pubtraffic/dataMapper'

get '/' do
  haml :index
end

get '/app.js' do
  coffee :app
end

get '/style.css' do
   sass :stylesheet, :style => :expanded
end


