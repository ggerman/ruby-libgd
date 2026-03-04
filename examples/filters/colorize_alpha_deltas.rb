require 'gd'

img = GD::Image.open("images/cat_piano.jpg")
img.filter(:colorize, 0, 0, 120, 250)

img.save("images/colorize-alpha.jpg")
