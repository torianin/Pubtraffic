#-*- coding: utf-8 -*-

require 'rubygems'
require 'serialport'
require 'pusher'
require 'data_mapper'

Pusher.app_id = '33866'
Pusher.key = '3da8282fe36a89d40595'
Pusher.secret = '13c7e7b331727ba51b93'

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

while true
	ser = SerialPort.new("/dev/tty.usbmodem1d121", 9600, 8, 1, SerialPort::NONE)
	code = ser.readline
	card = code[0..11]
	pub = code[12]
	p3 = User.get(card)
	puts card
	Pusher['my-channel'].trigger('my-event', {:message => "#{p3.nick} do puby numer #{pub}"})
end
