#-*- coding: utf-8 -*-

require 'data_mapper'
DataMapper::Logger.new(STDOUT, :debug) 
DataMapper.setup(:default, 'postgres://localhost/pubtraffic')

class Pub
  include DataMapper::Resource
  property :id, Serial, :key => true
  property :name, String
  property :discription, Text
  property :latlng, String
  property :users, String
  property :max, String
end

class User
  include DataMapper::Resource
  property :id, Integer
  property :nick, String
  property :card, String, :key => true
  property :gender, String
  property :email, String
  property :pub, String
  property :friends, Text
end

DataMapper.finalize.auto_migrate!

u = User.new
  u.attributes = {
  :id => '1',
  :nick => 'Torianin',
  :gender => 'male',
  :card => '0200A276E234',
  :email => 'tori@robert-i.com',
  :pub => '',
  :friends => '[]'
}
u.save

u = User.new
  u.attributes = {
  :id => '2',
  :nick => 'Natalia',
  :gender => 'female',
  :card => '0200A2BEFDE3',
  :email => 'liszka@gmail.com',
  :pub => '',
  :friends => '[]'
}
u.save

p = Pub.new
  p.attributes = {
  :name => 'Klub A',
  :discription => 'Nie ma nikogo',
  :latlng => '50.095896,18.542544',
  :users => '',
  :max => '10'
}
p.save

p = Pub.new
  p.attributes = {
  :name => 'Klub B',
  :discription => 'Nie ma nikogo',
  :latlng => '51.095896,18.542544',
  :users => '',
  :max => '10'
}
p.save