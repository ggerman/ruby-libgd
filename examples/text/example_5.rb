# ruby-libgd is evolving very fast, so some examples may temporarily stop working
# Please report issues or ask for help — feedback is very welcome
# https://github.com/ggerman/ruby-libgd/issues or ggerman@gmail.com

require "gd"
require_relative "fonts"

def deg(d)
  d * Math::PI / 180.0
end

cx = 300
cy = 200

img = GD::Image.new(600, 400)

8.times do |i|
  angle = deg(i * 45)

  img.text_ft(
    "ruby-libgd v0.2.2",
    x: cx,
    y: cy,
    font: GD::Fonts.random,
    size: 28,
    color: [255,80 + i*20,80],
    angle: angle,
    dpi: 144
  )
end

img.save("output/wheel.png")
