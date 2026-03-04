require 'gd'

img = GD::Image.open("images/cat_piano.jpg")
img.filter(:box_blur)

img.save("images/box_blur.jpg")