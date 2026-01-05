require "gd"

FONT = "/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf"

WIDTH  = 640
HEIGHT = 480
MARGIN = 60

img = GD::Image.new(WIDTH, HEIGHT)

# Colors
white = GD::Color.rgb(255,255,255)
black = GD::Color.rgb(0,0,0)
blue  = GD::Color.rgb(40,120,200)
red   = GD::Color.rgb(220,40,40)
gray  = GD::Color.rgb(220,220,220)

img.filled_rectangle(0,0,WIDTH,HEIGHT, white)

# Data
x_vals = (0..50).map { |i| i * 2*Math::PI / 50 }
y_vals = x_vals.map { |x| Math.sin(x) + 1.7 }

max_y = 3.0
min_y = 0.0

chart_w = WIDTH - 2*MARGIN
chart_h = HEIGHT - 2*MARGIN

# Axes
img.line(MARGIN, MARGIN, MARGIN, HEIGHT - MARGIN, black, thickness: 2)
img.line(MARGIN, HEIGHT - MARGIN, WIDTH - MARGIN, HEIGHT - MARGIN, black, thickness: 2)

# Horizontal grid + Y scale
(0..6).each do |i|
  y = HEIGHT - MARGIN - (i * chart_h / 6)
  v = min_y + i * (max_y - min_y) / 6

  img.line(MARGIN, y, WIDTH - MARGIN, y, gray)

  img.text(sprintf("%.1f", v), {
    x: MARGIN - 45,
    y: y + 5,
    size: 12,
    color: black,
    font: FONT
  })
end

# X scale
(0..6).each do |i|
  x = MARGIN + (i * chart_w / 6)
  v = i * Math::PI

  img.line(x, HEIGHT - MARGIN, x, HEIGHT - MARGIN + 6, black)

  img.text(sprintf("%.1f", v), {
    x: x - 10,
    y: HEIGHT - MARGIN + 25,
    size: 12,
    color: black,
    font: FONT
  })
end

# Baseline (y = 0)
zero_y = HEIGHT - MARGIN - ((0 - min_y) / (max_y - min_y)) * chart_h
img.line(MARGIN, zero_y, WIDTH - MARGIN, zero_y, red, thickness: 2)

# Stems + points
x_vals.each_with_index do |x, i|
  px = MARGIN + (x / (2*Math::PI)) * chart_w
  py = HEIGHT - MARGIN - ((y_vals[i] - min_y) / (max_y - min_y)) * chart_h

  # stem
  img.line(px, zero_y, px, py, blue)

  # point
  img.filled_circle(px, py, 4, blue)
end

img.save("images/stem_plot.png")
puts "Saved images/stem_plot.png"
