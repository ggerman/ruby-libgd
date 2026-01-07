require "gd"

src = GD::Image.open("big_map.png")
tile = GD::Image.new(256, 256)

tile.copy_resize(
  src,
  0, 0,      # dst
  0, 0,      # src
  src.width, src.height,
  256, 256,
  true       # resample
)

tile.save("tile.png")
