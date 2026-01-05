require "gd"

img = GD::Image.new(400,400)

blue  = GD::Color.rgb(0,120,255)
green = GD::Color.rgb(0,200,120)

img.line(50,50,350,350, blue)
img.rectangle(50,50,350,350, blue)
img.filled_circle(200,200,80, green)

poly = [
  [200,50],
  [350,200],
  [200,350],
  [50,200]
]
img.filled_polygon(poly, GD::Color.rgb(240,200,0))

img.save("images/shapes.png")
