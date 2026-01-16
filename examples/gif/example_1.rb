# ruby-libgd is evolving very fast, so some examples may temporarily stop working
# Please report issues or ask for help — feedback is very welcome
# https://github.com/ggerman/ruby-libgd/issues or ggerman@gmail.com

require "gd"

img1 = GD::Image.new(200,200)
red  = GD::Color.rgb(255,0,0)
img1.filled_rectangle(0,0,199,199, red)

img2 = GD::Image.new(200,200)
green = GD::Color.rgb(0,255,0)
img2.filled_rectangle(0,0,199,199, green)

gif = GD::Gif.new("test.gif")
gif.add_frame(img1, delay: 50)
gif.add_frame(img2, delay: 50)
gif.close
