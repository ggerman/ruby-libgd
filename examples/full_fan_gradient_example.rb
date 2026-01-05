require "gd"

WIDTH  = 400
HEIGHT = 500

img = GD::Image.new(WIDTH, HEIGHT)

# Colores del degradé
r1, g1, b1 = 255, 40, 40
r2, g2, b2 = 40,  40, 255

k_max = WIDTH + HEIGHT - 2

(0..k_max).each do |k|
  t = k.to_f / k_max

  r = (r1 + (r2 - r1) * t).round
  g = (g1 + (g2 - g1) * t).round
  b = (b1 + (b2 - b1) * t).round

  color = GD::Color.rgb(r, g, b)

  x0 = [0, k - (HEIGHT - 1)].max
  x1 = [WIDTH - 1, k].min

  # extremos del segmento x + y = k dentro del rectángulo
  y0 = k - x0
  y1 = k - x1

  img.line(x0, y0, x1, y1, color)
end

img.save("images/full_fan_gradient.png")
