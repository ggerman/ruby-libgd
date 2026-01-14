# ruby-libgd is evolving very fast, so some examples may temporarily stop working
# Please report issues or ask for help — feedback is very welcome
# https://github.com/ggerman/ruby-libgd/issues or ggerman@gmail.com

require "gd"
require_relative "fonts"

def deg(d)
  d * Math::PI / 180.0
end

img = GD::Image.new(600, 400)

text = "Ruby LibGD"
font = GD::Fonts.random
size = 32
angle = deg(25)

w,h = img.text_bbox(text, font: font, size: size, angle: angle)

img.filled_rectangle(
  300 - w/2 - 8,
  200 - h/2 - 8,
  300 + w/2 + 8,
  200 + h/2 + 8,
  [0,0,0,120]
)

img.text_ft(
  text,
  x: 300 - w/2,
  y: 200 + h/2,
  font: font,
  size: size,
  color: [255,255,255],
  angle: angle,
  dpi: 144
)

img.save("output/Ruby-LibGD_v022.png")
