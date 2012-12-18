require 'rubygems'
require 'serialport'
require 'pusher'

Pusher.app_id = '33866'
Pusher.key = '3da8282fe36a89d40595'
Pusher.secret = '13c7e7b331727ba51b93'

while true
	ser = SerialPort.new("/dev/tty.usbmodem1a111", 9600, 8, 1, SerialPort::NONE)
	myStr = ser.readline(200)	
	puts myStr
	Pusher['my-channel'].trigger('my-event', {:message => "#{myStr}"})
	aFile = File.new("users.txt", "w")
	aFile.write(myStr)
	aFile.close
end
