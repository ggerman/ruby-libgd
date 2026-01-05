require "gd"

WIDTH  = 640
HEIGHT = 480
MARGIN = 60

img = GD::Image.new(WIDTH, HEIGHT)

# Colors
white  = GD::Color.rgb(255,255,255)
black  = GD::Color.rgb(0,0,0)
red    = GD::Color.rgb(220,60,60)
blue   = GD::Color.rgb(60,100,220)
orange = GD::Color.rgb(255,140,40)
gray   = GD::Color.rgb(200,200,200)

# Background
img.filled_rectangle(0,0,WIDTH,HEIGHT, white)

# Data
labels = ["apple", "blueberry", "cherry", "orange"]
values = [40, 100, 30, 55]
colors = [red, blue, red, orange]

max_value = 120.0
chart_height = HEIGHT - 2*MARGIN
bar_width = 80
gap = 40

# Axes
img.line(MARGIN, MARGIN, MARGIN, HEIGHT - MARGIN, black, thickness: 2)
img.line(MARGIN, HEIGHT - MARGIN, WIDTH - MARGIN, HEIGHT - MARGIN, black, thickness: 2)

# Grid
(0..6).each do |i|
  y = HEIGHT - MARGIN - (i * chart_height / 6)
  img.line(MARGIN, y, WIDTH - MARGIN, y, gray)
end

# Bars
labels.each_with_index do |label, i|
  x = MARGIN + 40 + i * (bar_width + gap)

  h = (values[i] / max_value) * chart_height
  y = HEIGHT - MARGIN - h

  img.filled_rectangle(x, y, x + bar_width, HEIGHT - MARGIN, colors[i])
  img.rectangle(x, y, x + bar_width, HEIGHT - MARGIN, black, thickness: 2)
end

img.save("images/fruit_chart.png")
puts "Saved images/fruit_chart.png"
