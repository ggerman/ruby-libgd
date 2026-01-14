# ruby-libgd is evolving very fast, so some examples may temporarily stop working
# Please report issues or ask for help — feedback is very welcome
# https://github.com/ggerman/ruby-libgd/issues or ggerman@gmail.com

require "gd"
require_relative "fonts"

def deg(d)
  d * Math::PI / 180.0
end

img = GD::Image.new(600, 400)
img.filled_rectangle(0,0,599,399,[30,30,30])

img.text_ft(
  "Ruby LibGD",
  x: 50,
  y: 370,
  font: GD::Fonts.random,
  size: 48,
  color: [255,255,255],
  angle: deg(30),
  dpi: 144
)

img.save("output/rotate_01.png")
