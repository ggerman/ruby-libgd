require 'gd'

img = GD::Image.open("images/cat_piano.jpg")
img.filter(:gaussian_kernel)

img.save("images/gaussian_kernel.jpg")