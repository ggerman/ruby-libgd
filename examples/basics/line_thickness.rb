require "gd"

SIZE = 300

img = GD::Image.new(SIZE, SIZE)

# fondo blanco
white = GD::Color.rgb(255,255,255)
img.filled_rectangle(0,0,SIZE,SIZE, white)

blue = GD::Color.rgb(40,90,220)
red  = GD::Color.rgb(200,50,50)

# línea normal (grosor 1)
img.line(20, 50, 280, 50, blue)

# línea doble
img.line(20, 100, 280, 100, red, thickness: 20)

# línea triple
img.line(20, 150, 280, 150, blue, thickness: 3)

# línea gruesa
img.line(20, 220, 280, 220, red, thickness: 6)

img.save("images/lines.png")

puts "Saved images/lines.png"
