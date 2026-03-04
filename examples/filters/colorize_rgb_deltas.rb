require 'gd'

img = GD::Image.open("images/cat_piano.jpg")
img.filter(:colorize, 80, 0, 0)

img.save("images/colorize-rgb.jpg")
