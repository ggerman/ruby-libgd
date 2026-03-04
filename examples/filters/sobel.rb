require 'gd'

img = GD::Image.open("images/cat_piano.jpg")

img.filter(:sobel)

img.save("images/sobel.jpg")