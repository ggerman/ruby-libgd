require "gd"

img = GD::Image.open("images/draw.jpg")

thumb = img.crop(100,100,300,300)
thumb = thumb.resize(200,200)

thumb.save("images/thumb.png")
