# ruby-libgd is evolving very fast, so some examples may temporarily stop working
# Please report issues or ask for help — feedback is very welcome
# https://github.com/ggerman/ruby-libgd/issues or ggerman@gmail.com

require "gd"
require_relative "fonts"

img = GD::Image.new(600, 200)

w, h = img.text_bbox(
  "Hello GD",
  font: GD::Fonts.random,
  size: 32
)

puts "Text size: #{w} x #{h}"
