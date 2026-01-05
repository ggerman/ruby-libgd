require "gd"

img = GD::Image.new(300,300)
img.save_alpha = true
img.alpha_blending = true

bg = GD::Color.rgba(0,0,0,127)      # fully transparent
red = GD::Color.rgba(255,0,0,64)    # semi-transparent red

img.filled_rectangle(0,0,300,300, bg)
img.filled_circle(150,150,100, red)

img.save("images/alpha.png")
