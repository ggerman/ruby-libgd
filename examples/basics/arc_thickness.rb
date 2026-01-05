require "gd"

SIZE = 400

img = GD::Image.new(SIZE, SIZE)

white = GD::Color.rgb(255,255,255)
red   = GD::Color.rgb(200,40,40)
blue  = GD::Color.rgb(40,90,220)
green = GD::Color.rgb(40,180,80)

# background
img.filled_rectangle(0,0,SIZE,SIZE, white)

# thin arc
img.arc(200,200,300,300, 0, 270, red)

# thick arc
img.arc(200,200,260,260, 0, 270, blue, thickness: 6)

# filled arc
img.filled_arc(200,200,200,200, 0, 180, green)

img.save("images/arc_thickness.png")

puts "Saved images/arc_thickness.png"
