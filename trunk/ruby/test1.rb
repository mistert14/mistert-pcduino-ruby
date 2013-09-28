require 'rubygems'
require 'pcduino'
require 'fox16'

include Fox
 
HIGH=true
LOW=false

class Duino < FXMainWindow
	
def initialize(app, title, w, h)  
    @pin = Pin.new(1)
    @pin.set_as_output()
    super(app, title, :width => w, :height => h)  
    add_quit_button
    add_high_button
    add_low_button
  end  
  def create  
    super  
    show(PLACEMENT_SCREEN)  
  end 
 
  def add_quit_button  
	  btn_quit = FXButton.new(self, "Quitter") 
	  btn_quit.connect(SEL_COMMAND) do  
		exit
	  end  
  end

 def add_high_button  
	  btn_high = FXButton.new(self, "High 0") 
	  btn_high.connect(SEL_COMMAND) do  
		@pin.write(1);
	  end  
  end

def add_low_button  
	  btn_low = FXButton.new(self, "Low 0") 
	  btn_low.connect(SEL_COMMAND) do  
		@pin.write(0);
	  end  
  end

end  

app = FXApp.new  
Duino.new(app, "Duino forge -- misterT", 250, 100)  
app.create  
app.run  


