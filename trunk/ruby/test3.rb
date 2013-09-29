require 'rubygems'
require 'pcduino'
require 'fox16'

include Fox

HIGH=true
LOW=false

class Duino < FXMainWindow

def initialize(app, title, w, h) 
    @app=app
    @timer=0
     #port 0..7 comme sortie	
    @pin=Array.new()
     for i in 0..7:
	     @pin[i]  = Pin.new(i)
             @pin[i].set_as_output()
	     @pin[i].write(0)
     end
     #port 8..13 comme entree pullup
     for i in 8..13:
	     @pin[i]  = Pin.new(i)
             @pin[i].set_as_input_pu()
	     
    end
    super(app, title, :width => w, :height => h)  
    @label=FXLabel.new(self, @timer.to_s) 
    add_quit_button
    for i in 0..7:
	add_high_button(i)
	add_low_button(i)
    end
    @app.addTimeout(1000, method(:update_timer))         
     
      
  end  
  
  
  def update_timer(sender, selector, data)
      @timer+=1
      @label.text=@timer.to_s
      @app.addTimeout(1000, method(:update_timer))
  end
  
  

  def create  
    super  
    show(PLACEMENT_SCREEN)  
  end 
 
  def add_quit_button  
	  btn_quit = FXButton.new(self, "Quitter") 
	  btn_quit.connect(SEL_COMMAND) do  
		exit
		@label.text="toto"
	  end  
  end

 def add_high_button(num)  
	  btn_high = FXButton.new(self, "High "+num.to_s) 
	  btn_high.connect(SEL_COMMAND) do  
		@pin[num].write(1);
	  end  
  end

def add_low_button (num)
	  btn_low = FXButton.new(self, "Low "+num.to_s) 
	  btn_low.connect(SEL_COMMAND) do  
		@pin[num].write(0);
	  end  
  end

end  

app = FXApp.new  
win=Duino.new(app, "Duino forge -- misterT", 100, 500)  
app.create 
app.run 


 
 



