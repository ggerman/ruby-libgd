require 'gd'

img = GD::Image.open("images/the_dark_forest.jpeg")

kernel = [
    [-1, -1, -1],
    [-1,  8, -1],
    [-1, -1, -1]
]

img.filter(:convolve, kernel, 1.0, 0.0)
img.save("images/avatar-convolve-#{rand(99)}.jpg")
