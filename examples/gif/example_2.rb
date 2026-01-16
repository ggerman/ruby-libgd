# ruby-libgd is evolving very fast, so some examples may temporarily stop working
# Please report issues or ask for help — feedback is very welcome
# https://github.com/ggerman/ruby-libgd/issues or ggerman@gmail.com

require "gd"

W = 300
H = 300
CX = W / 2
CY = H / 2

gif = GD::Gif.new("pulse.gif")

20.times do |i|
  img = GD::Image.new(W, H)

  # fondo negro
  black = GD::Color.rgb(0,0,0)
  img.filled_rectangle(0,0,W,H, black)

  # pulso (0..1..0)
  t = i / 19.0
  pulse = Math.sin(t * Math::PI)

  radius = (pulse * 120).to_i + 10

  # color que cambia
  r = (255 * pulse).to_i
  g = (255 * (1 - pulse)).to_i
  b = (128 + 127 * Math.sin(t * 2 * Math::PI)).to_i

  color = GD::Color.rgb(r,g,b)

  img.filled_ellipse(CX, CY, radius*2, radius*2, color)

  gif.add_frame(img, delay: 5)
end

gif.close
