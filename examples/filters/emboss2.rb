require 'gd'

img = GD::Image.open("images/cat_piano.jpg")
img.filter(:emboss2)

img.save("images/emboss2.jpg")