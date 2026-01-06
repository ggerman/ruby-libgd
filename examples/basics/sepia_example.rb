require "gd"

img = GD::Image.open("images/photo.jpeg")
img.filter(:sepia)
img.save("images/vintage.jpg")
