# ruby-libgd is evolving very fast, so some examples may temporarily stop working
# Please report issues or ask for help — feedback is very welcome
# https://github.com/ggerman/ruby-libgd/issues or ggerman@gmail.com

require "gd"
require_relative "fonts"

img = GD::Image.new(600, 400)
img.filled_rectangle(0,0,599,399,[240,240,240])


img.line(50,300,550,100,[80,80,80])

img.text_ft(
  "Highway #{rand(9999)}",
  x: 300,
  y: 200,
  font: GD::Fonts.find("Sans") || GD::Fonts.random,
  size: 24,
  color: [0,0,0],
  angle: Math.atan2(100-300, 550-50),
  dpi: 144
)

img.save("output/road_label.png")
