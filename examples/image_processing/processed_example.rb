require "gd"

img = GD::Image.open("images/draw.jpg")

puts img.width
puts img.height

img.filter(:grayscale)
img.filter(:brightness, 20)

img.save("images/processed.jpg")
