#-*- coding: utf-8 -*-

require 'rubygems'
require 'serialport'
require 'pusher'
require '/Users/Robert/Documents/Pubtraffic/dataMapper'

Pusher.app_id = '33866'
Pusher.key = '3da8282fe36a89d40595'
Pusher.secret = '13c7e7b331727ba51b93'

while true
	# Odczytywanie przyłożonej karty
	ser = SerialPort.new("/dev/tty.usbmodem1d121", 9600, 8, 1, SerialPort::NONE)
	code = ser.readline
	#Odczytywanie kodu użytkownika
	card = code[0..11]
	#Odczytywanie kodu pubu
	pub = code[12]
	#Wypisanie użytkownika
	puts card
	#Pobranie użytkownika i jego nicka 
	pubuser = User.get(card)
	nick = pubuser.nick
	pubuser.update(:pub => pub)
	#Pobranie pubu zgodnego z kodem pubu
  pub = Pub.get(pub)
  #Sprawdzenie użytkowników w pubie
  if(pub.users!='' && pub.users!='[]')
  	re = Regexp.new('([A-Z]\w*)')
  	uzytkownicy_pubu = Array.new
  	uzytkownicy_pubu = re.match(pub.users).captures
  else
  	uzytkownicy_pubu = Array.new
  	uzytkownicy_pubu = pub.users.split
  end
  puts uzytkownicy_pubu
  puts uzytkownicy_pubu.class
  puts uzytkownicy_pubu.include?(pubuser.nick)
	if (uzytkownicy_pubu.include?(pubuser.nick) )
  	uzytkownicy_pubu.delete(pubuser.nick)
  	pub.update(:users => uzytkownicy_pubu.to_s)
  	puts pub.users.to_s
  	puts pub.users.class
	  	if (pubuser.gender == 'male')
	  		Pusher['my-channel'].trigger('my-event', {:message => "wyszedł #{pubuser.nick} do pubu #{pub.name}"})
	  	else
	  		Pusher['my-channel'].trigger('my-event', {:message => "wyszła #{pubuser.nick} do pubu #{pub.name}"})
	  	end
  	else
  	uzytkownicy_pubu << pubuser.nick
  	pub.update(:users => uzytkownicy_pubu.to_s)
  	puts pub.users.to_s
  	puts pub.users.class
  		if (pubuser.gender == 'male')
  			Pusher['my-channel'].trigger('my-event', {:message => "wszedł #{pubuser.nick} do pubu #{pub.name}"})
  		else
  			Pusher['my-channel'].trigger('my-event', {:message => "weszła #{pubuser.nick} do pubu #{pub.name}"})
  	end
  end
end
