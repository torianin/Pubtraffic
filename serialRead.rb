require 'rubygems'
require 'serialport'
require 'pusher'

Pusher.app_id = '33866'
Pusher.key = '3da8282fe36a89d40595'
Pusher.secret = '13c7e7b331727ba51b93'

aFile = File.new("users.txt", "w")

while true
	ser = SerialPort.new("/dev/tty.usbmodem1d121", 9600, 8, 1, SerialPort::NONE)
	myStr = ser.readline(200)	
	puts myStr
	Pusher['my-channel'].trigger('my-event', {:message => "#{myStr}"})
	aFile.write(myStr)
	aFile.close
end
