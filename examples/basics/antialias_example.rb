require "gd"

img = GD::Image.new(900, 600)
img.antialias = true

bg    = GD::Color.rgb(20, 22, 30)
grid  = GD::Color.rgba(255,255,255,40)
blue  = GD::Color.rgba(80,160,255,180)
red   = GD::Color.rgba(255,80,80,200)
green = GD::Color.rgba(80,200,120,180)
white = GD::Color.rgb(255,255,255)

img.filled_rectangle(0, 0, 899, 599, bg)

(0..900).step(50) { |x| img.line(x, 0, x, 599, grid) }
(0..600).step(50) { |y| img.line(0, y, 899, y, grid) }

img.filled_ellipse(350, 300, 350, 240, blue)
img.filled_ellipse(500, 280, 350, 240, green)
img.filled_ellipse(430, 360, 350, 240, red)

img.ellipse(430, 360, 350, 240, white)

img.save("antialias_demo.png")
