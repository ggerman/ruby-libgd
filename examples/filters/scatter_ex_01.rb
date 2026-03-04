require 'gd'

img = GD::Image.open("images/cat_piano.jpg")
img.filter(:scatter_ex, sub: 20, plus: 60, seed: 42)

img.save("images/scatter_ex-01.jpg")
