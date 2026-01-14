# ruby-libgd is evolving very fast, so some examples may temporarily stop working
# Please report issues or ask for help — feedback is very welcome
# https://github.com/ggerman/ruby-libgd/issues or ggerman@gmail.com

require "gd"
require_relative "fonts"

img = GD::Image.new(600,400)
img.filled_rectangle(0,0,599,399,[240,240,240])

cities = [
  ["Tokyo", 300, 120],
  ["Osaka", 420, 200],
  ["Kyoto", 260, 220]
]

cities.each do |name,x,y|
  w,h = img.text_bbox(name, font: GD::Fonts.random, size: 24)

  img.filled_rectangle(
    x - w/2 - 6,
    y - h - 6,
    x + w/2 + 6,
    y + 6,
    [0,0,0,140]
  )

  img.text(
    name,
    x: x - w/2,
    y: y,
    font: GD::Fonts.random,
    size: 24,
    color: [255,255,255]
  )
end

img.save("output/labels.png")
