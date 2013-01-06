#-*- coding: utf-8 -*-

require 'sinatra'
require 'haml'
require 'coffee-script'
require 'sass'
require 'data_mapper'

DataMapper.setup(:default, 'postgres://localhost/pubtraffic')

class Pub
  include DataMapper::Resource
  property :id, Serial, :key => true
  property :name, String
  property :users, String
end

class User
  include DataMapper::Resource
  property :nick, String
  property :card, String, :key => true
  property :email, String
  property :friends, String
end

DataMapper.auto_migrate!

p = User.new
  p.attributes = {
  :nick => 'Torianin',
  :card => '0200A276E234',
  :email => 'tori@robert-i.com'
  }
  p.save

p = User.new
  p.attributes = {
  :nick => 'Natalia',
  :card => '0200A2BEFDE3',
  :email => 'liszka@gmail.com'
  }
  p.save

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


