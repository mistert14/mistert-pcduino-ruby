require 'rubygems'
require 'pcduino'

HIGH=true
LOW=false

pin0= Pin.new(0)
pin0.set_as_output()

pin0.write(1)
sleep(2)
pin0.write(0)
sleep(2)


