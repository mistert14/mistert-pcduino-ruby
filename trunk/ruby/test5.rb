libdir = File.expand_path(File.dirname(__FILE__))
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

require 'rubygems'
require 'fox16'
require 'pcduino'

include Fox
include Pcduino

HIGH=true
LOW=false

class Duino < FXMainWindow

def initialize(app, title, w, h)
    
    @app=app
    @timer=0
     #port 0..7 comme sortie
    @pin=Array.new()
     for i in (0..7) do
             @pin[i]  = Pin.new(i)
             @pin[i].set_as_output()
             @pin[i].write(0)
     end
     #port 8..13 comme entree pullup
     for i in (8..13) do
             @pin[i]  = Pin.new(i)
             @pin[i].set_as_input_pu()

    end
    super(app, title, :width => w, :height => h)
    @packer = FXPacker.new(self, :opts => LAYOUT_FILL)
    @label=FXLabel.new(@packer, File.dirname(__FILE__))
    add_quit_button
    for i in (0..7) do
        add_high_button(i)
        add_low_button(i)
end
add_memo
    @app.addTimeout(1000, method(:update_timer))


  end

 def update_timer(sender, selector, data)
      @timer+=1
      @label.text=@timer.to_s
      #self.title=@timer.to_s
      #TODO LIRE ENTREES NUMERIQUES ET ANALOGIQUES
      s=''
      for i in (8..13) do
	s+='Pin '+i.to_s+' = '+@pin[i].read.to_s+"\n" 
      end
      @memo1.text=s
      @app.addTimeout(1000, method(:update_timer))
  end



  def create
    super
    show(PLACEMENT_SCREEN)
  end

  def add_quit_button
          btn_quit = FXButton.new(@packer, "Quitter",:opts => BUTTON_NORMAL|LAYOUT_SIDE_BOTTOM)
          btn_quit.connect(SEL_COMMAND) do
                exit
                
          end
  end

 def add_memo
	 @memo1 = FXText.new(@packer, :opts => TEXT_WORDWRAP|LAYOUT_FIX_X|LAYOUT_FIX_Y|LAYOUT_FIX_WIDTH|LAYOUT_FIX_HEIGHT, :x=> 100,  :y=> 15, :width=>230, :height=>220)
	 
	 @memo1.text='Waiting for inputs'
	 @memo1.editable=false
 end	 

 def add_high_button(num)
          btn_high = FXButton.new(@packer, "High "+num.to_s, :opts => BUTTON_NORMAL|LAYOUT_FIX_X|LAYOUT_FIX_Y, :x => 5, :y => 20*(num+1))
          btn_high.connect(SEL_COMMAND) do
                @pin[num].write(1);
          end
  end

def add_low_button (num)
          btn_low = FXButton.new(@packer, "Low "+num.to_s, :opts => BUTTON_NORMAL|LAYOUT_FIX_X|LAYOUT_FIX_Y, :x => 50, :y => 20*(num+1))
          btn_low.connect(SEL_COMMAND) do
                @pin[num].write(0);
          end
  end

end


if __FILE__ == $0
	puts "toto"
	FXApp.new do |app|
		win=Duino.new(app, "Duino forge -- misterT", 340, 250)
		app.create
		app.run
	end
	
end


