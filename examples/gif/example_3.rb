# ruby-libgd is evolving very fast, so some examples may temporarily stop working
# Please report issues or ask for help — feedback is very welcome
# https://github.com/ggerman/ruby-libgd/issues or ggerman@gmail.com

require "gd"

W = 300
H = 200

x = 50
y = 50
vx = 4
vy = 3
r  = 12

gif = GD::Gif.new("bounce.gif")

60.times do
  img = GD::Image.new(W, H)

  # fondo
  black = GD::Color.rgb(0,0,0)
  img.filled_rectangle(0,0,W,H, black)

  # rebote contra paredes
  if x - r <= 0 || x + r >= W
    vx = -vx
  end
  if y - r <= 0 || y + r >= H
    vy = -vy
  end

  x += vx
  y += vy

  # color según velocidad
  speed = Math.sqrt(vx*vx + vy*vy)
  color = GD::Color.rgb(
    100 + speed * 20,
    180,
    255 - speed * 20
  )

  img.filled_ellipse(x, y, r*2, r*2, color)

  gif.add_frame(img, delay: 5)
end

gif.close
