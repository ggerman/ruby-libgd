require "gd"

img = GD::Image.new(600,400)

white = GD::Color.rgb(255,255,255)
black = GD::Color.rgb(0,0,0)
red   = GD::Color.rgb(180,0,0)
blue  = GD::Color.rgb(0,120,255)

img.fill(white)

img.rectangle(1,1,598,398, black)
img.rectangle(3,3,596,396, black)

img.filled_circle(300,200,120, red)

img.save("images/rectangle_circle_example.png")
