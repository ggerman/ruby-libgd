require "gd"

SIZE = 400

img = GD::Image.new(SIZE, SIZE)

white = GD::Color.rgb(255,255,255)
red   = GD::Color.rgb(200,40,40)
blue  = GD::Color.rgb(40,90,220)
green = GD::Color.rgb(40,180,80)

# Fondo
img.filled_rectangle(0,0,SIZE,SIZE, white)

# Círculo fino (por defecto thickness = 1)
img.circle(200,200,150, red)

# Círculo grueso
img.circle(200,200,120, blue, thickness: 8)

# Círculo relleno con borde grueso
img.filled_circle(200,200,80, green, thickness: 5)

img.save("images/circle_demo.png")

puts "Saved images/circle_demo.png"
