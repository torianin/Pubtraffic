#-*- coding: utf-8 -*-

require 'data_mapper'
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
  property :email, String
  property :friends, Text
end

DataMapper.finalize.auto_migrate!

u = User.new
  u.attributes = {
  :id => '1',
  :nick => 'Torianin',
  :card => '0200A276E234',
  :email => 'tori@robert-i.com',
  :friends => '[]'
}
u.save

u = User.new
  u.attributes = {
  :id => '2',
  :nick => 'Natalia',
  :card => '0200A2BEFDE3',
  :email => 'liszka@gmail.com',
  :friends => '[]'
}
u.save

p = Pub.new
  p.attributes = {
  :name => 'Klub VIP',
  :discription => 'Nie ma nikogo',
  :latlng => '50.095896,18.542544',
  :users => '[]',
  :max => '10'
}
p.save