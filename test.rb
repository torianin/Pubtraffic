#-*- coding: utf-8 -*-
 
require 'rubygems'
require 'data_mapper'
require 'serialport'
require 'pusher'
require 'dm-postgres-adapter'
require 'gtk2'

Pusher.app_id = '33866'
Pusher.key = '3da8282fe36a89d40595'
Pusher.secret = '13c7e7b331727ba51b93'
 
DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, 'postgres://pub1:aaa@192.168.1.150:8000/pubtraffic')
 
class Pub
  include DataMapper::Resource
  property :id, Serial, :key => true
  property :name, String
  property :discription, Text
  property :users, CommaSeparatedList
  property :latlng, String
  property :max, String
end
 
class User
  include DataMapper::Resource
  property :id, Integer
  property :nick, String
  property :card, String, :key => true
  property :pub, Integer
  property :gender, String
  property :email, String
  property :friends, CommaSeparatedList
end
 
DataMapper.finalize.auto_migrate!
 
u = User.new
  u.attributes = {
  :id => '1',
  :nick => 'Torianin',
  :gender => 'male',
  :card => '0200A276E234',
  :email => 'tori@robert-i.com',
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
  :friends => '[]'
}
u.save

u = User.new
  u.attributes = {
  :id => '3',
  :nick => 'Szymon',
  :gender => 'male',
  :card => '010031565C3A',
  :email => 'szymon@gmail.com',
  :friends => '[]'
}

u.save
p = Pub.new
  p.attributes = {
  :name => 'Klub A',
  :discription => 'Nie ma nikogo',
  :users => '',
  :latlng => '50.095896,18.542544',
  :max => '10'
}
p.save
 
p = Pub.new
  p.attributes = {
  :name => 'Klub B',
  :discription => 'Nie ma nikogo',
  :users => '',
  :latlng => '51.095896,18.542544',
  :max => '10'
}
p.save



class RubyApp < Gtk::Window

    def initialize
        super
    
        set_title "Center"
        signal_connect "destroy" do 
            Gtk.main_quit 
        end

        set_default_size 250, 200
        set_window_position Gtk::Window::POS_CENTER
        
        show
    end
end

Gtk.init
    window = RubyApp.new
Gtk.main
# Odczytywanie przy?o?onej karty
sp = SerialPort.new "/dev/tty.usbmodem1d121", 9600
while true     
  code = sp.gets
  card = code[0...12]
  pubnumer = 1
  puts card
  #Pobranie u?ytkownika i jego nicka
  pubuser = User.get(card)
  nick = pubuser.nick
  pubnow = Pub.get(pubnumer)
  puts pubnow.id
  pubuser.update(:pub => pubnumer)
  pub = Pub.get(pubnumer)
  puts pub.users
  puts pub.users.class
  puts pub.users.include?(pubuser.nick)
  if (pub.users.include?(pubuser.nick) )
    pub.users.delete(pubuser.nick)
    pub.save
    puts pub.users.to_s
    puts pub.users.class
      if (pubuser.gender == 'male')
        Pusher['my-channel'].trigger('my-event', {:message => "wyszedł #{pubuser.nick} do pubu #{pub.name}"})
      else
        Pusher['my-channel'].trigger('my-event', {:message => "wyszła #{pubuser.nick} do pubu #{pub.name}"})
      end
    else
    pub.users << nick
    pub.save
    puts pub.users.to_s
    puts pub.users.class
      if (pubuser.gender == 'male')
        Pusher['my-channel'].trigger('my-event', {:message => "wszedł #{pubuser.nick} do pubu #{pub.name}"})
      else
        Pusher['my-channel'].trigger('my-event', {:message => "weszła #{pubuser.nick} do pubu #{pub.name}"})
    end
  end
end
