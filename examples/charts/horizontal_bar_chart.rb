require "gd"

FONT = "/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf"

WIDTH  = 640
HEIGHT = 480
MARGIN = 70

img = GD::Image.new(WIDTH, HEIGHT)

# Colors
white = GD::Color.rgb(255,255,255)
black = GD::Color.rgb(0,0,0)
blue  = GD::Color.rgb(40,120,200)
gray  = GD::Color.rgb(220,220,220)

img.filled_rectangle(0,0,WIDTH,HEIGHT, white)

names  = ["Tom", "Dick", "Harry", "Slim", "Jim"]
values = [10.0, 10.5, 10.0, 8.5, 13.0]
errors = [0.71, 0.25, 0.16, 0.70, 0.72]

max_value = 16.0
chart_width = WIDTH - 2*MARGIN
chart_height = HEIGHT - 2*MARGIN

bar_height = chart_height / names.size - 10

# Title
img.text("How fast do you want to go today?", {
  x: 150,
  y: 35,
  size: 20,
  color: black,
  font: FONT
})

# X axis
img.line(MARGIN, HEIGHT - MARGIN, WIDTH - MARGIN, HEIGHT - MARGIN, black, thickness: 2)

# X scale + grid
(0..8).each do |i|
  x = MARGIN + i * chart_width / 8
  v = (i * max_value / 8).to_i

  img.line(x, HEIGHT - MARGIN, x, HEIGHT - MARGIN + 6, black)
  img.line(x, MARGIN, x, HEIGHT - MARGIN, gray)

  img.text(v.to_s, {
    x: x - 8,
    y: HEIGHT - MARGIN + 22,
    size: 12,
    color: black,
    font: FONT
  })
end

# Y labels + bars
names.each_with_index do |name, i|
  y = MARGIN + i * (bar_height + 10)

  bar_len = (values[i] / max_value) * chart_width

  img.filled_rectangle(MARGIN, y, MARGIN + bar_len, y + bar_height, blue)
  img.rectangle(MARGIN, y, MARGIN + bar_len, y + bar_height, black, thickness: 2)

  # Error bar
  err = (errors[i] / max_value) * chart_width
  cx = MARGIN + bar_len

  img.line(cx - err, y + bar_height/2, cx + err, y + bar_height/2, black, thickness: 2)
  img.line(cx - err, y + bar_height/2 - 5, cx - err, y + bar_height/2 + 5, black)
  img.line(cx + err, y + bar_height/2 - 5, cx + err, y + bar_height/2 + 5, black)

  # Name
  img.text(name, {
    x: 15,
    y: y + bar_height/2 + 6,
    size: 14,
    color: black,
    font: FONT
  })

  # Error label
  img.text(sprintf("±%.2f", errors[i]), {
    x: cx + err + 10,
    y: y + bar_height/2 + 6,
    size: 14,
    color: GD::Color.rgb(0,0,255),
    font: FONT
  })
end

img.save("images/horizontal_bar_chart_640.png")
puts "Saved images/horizontal_bar_chart_640.png"
