require 'gd'

img = GD::Image.open("images/cat_piano.jpg")

img.filter(:sharpen)

img.save("images/sharpen.jpg")