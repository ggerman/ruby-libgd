# ruby-libgd is evolving very fast, so some examples may temporarily stop working
# Please report issues or ask for help — feedback is very welcome
# https://github.com/ggerman/ruby-libgd/issues or ggerman@gmail.com

require "gd"
require_relative "fonts"

img = GD::Image.new(800, 400)
img.filled_rectangle(0,0,799,399,[20,20,20])

5.times do |i|
  img.text_ft(
    "ruby-libgd",
    x: 50,
    y: 80 + i*60,
    font: GD::Fonts.random,
    size: 48,
    color: [255, 180 - i*20, 80 + i*30],
    dpi: 144
  )
end

img.save("output/random_fonts.png")
