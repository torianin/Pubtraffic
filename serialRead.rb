#-*- coding: utf-8 -*-

require 'rubygems'
require 'serialport'
require 'pusher'
load 'dataMapper.rb'  

Pusher.app_id = '33866'
Pusher.key = '3da8282fe36a89d40595'
Pusher.secret = '13c7e7b331727ba51b93'

while true
	ser = SerialPort.new("/dev/tty.usbmodem1d121", 9600, 8, 1, SerialPort::NONE)
	code = ser.readline
	card = code[0..11]
	pub = code[12]
	p3 = User.get(card)
	puts card
  pub = Pub.get(1)
  nick = p3.nick
  pub.update(:users => nick)
	Pusher['my-channel'].trigger('my-event', {:message => "#{p3.nick} do puby numer #{pub}"})
end
