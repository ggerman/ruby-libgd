require "gd"

base = GD::Image.open("images/background.png")
overlay = GD::Image.open("images/photo.png")

overlay.filter(:gaussian_blur)
overlay.filter(:brightness, 40)

base.copy_merge(overlay, 30,30, 0,0, overlay.width, overlay.height, 70)
base.save("images/merged.png")
