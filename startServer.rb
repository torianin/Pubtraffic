#-*- coding: utf-8 -*-

require 'sinatra'
require 'haml'
require 'coffee-script'
require 'sass'
require 'json'
require 'data_mapper'
require '/Users/Robert/Documents/Pubtraffic/dataMapperClean'


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

get '/pubs.json' do
  content_type :json
  pubs = Pub.all
  ids = Array.new
  pubs.each {|x| ids << x.id}
  names = Array.new
  pubs.each {|x| names << x.name}
  discriptions = Array.new
  pubs.each {|x| discriptions << x.discription}
  latlngs = Array.new
  pubs.each {|x| latlngs << x.latlng}
  users = Array.new
  pubs.each {|x| users << x.users}
  maxs = Array.new
  pubs.each {|x| maxs << x.max}
  {:id => ids, :name => names, :discription => discriptions , :latlng => latlngs, :max => maxs}.to_json
end

