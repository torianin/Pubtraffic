require 'data_mapper'

DataMapper::Logger.new(STDOUT, :debug) 
DataMapper.setup(:default, 'postgres://pub1:aaa@192.168.1.150:8000/pubtraffic')

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