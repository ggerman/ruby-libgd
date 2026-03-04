require 'gd'

img = GD::Image.open("images/cat_piano.jpg")
img.filter(:laplacian)

img.save("images/laplacian.jpg")
