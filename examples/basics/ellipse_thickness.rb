require "gd"

SIZE = 400

img = GD::Image.new(SIZE, SIZE)

white = GD::Color.rgb(255,255,255)
red   = GD::Color.rgb(200,40,40)
blue  = GD::Color.rgb(40,90,220)
green = GD::Color.rgb(40,180,80)

# Fondo
img.filled_rectangle(0,0,SIZE,SIZE, white)

# Elipse fina
img.ellipse(200,200,300,200, red)

# Elipse gruesa
img.ellipse(200,200,260,160, blue, thickness: 8)

# Elipse rellena con borde
img.filled_ellipse(200,200,180,120, green, thickness: 5)

img.save("images/ellipse_demo.png")

puts "Saved images/ellipse_demo.png"
