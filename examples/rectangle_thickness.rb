require "gd"

SIZE = 400

img = GD::Image.new(SIZE, SIZE)

# Colors
white = GD::Color.rgb(255,255,255)
red   = GD::Color.rgb(200,40,40)
blue  = GD::Color.rgb(40,90,220)
green = GD::Color.rgb(40,180,80)

# Background
img.filled_rectangle(0,0,SIZE,SIZE, white)

# Thin rectangle (default)
img.rectangle(40,40,360,360, red)

# Thick rectangle
img.rectangle(80,80,320,320, blue, thickness: 6)

# Filled rectangle with thick border
img.filled_rectangle(120,120,280,280, green, thickness: 4)

img.save("rectangle_thickness.png")

puts "Saved rectangle_thickness.png"
