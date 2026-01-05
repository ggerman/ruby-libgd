require "gd"

WIDTH  = 800
HEIGHT = 400

img = GD::Image.new(WIDTH, HEIGHT)

# ----------------------------
# Pastel palette
# ----------------------------
bg_top    = [244, 240, 255]   # lavender
bg_bottom = [230, 248, 255]   # light sky

accent1 = [255, 140, 180]    # pastel pink
accent2 = [120, 200, 255]    # pastel blue
text_main = [60, 70, 120]    # deep indigo
shadow = [180, 190, 220]

# ----------------------------
# Soft gradient background
# ----------------------------
(0...HEIGHT).each do |y|
  t = y.to_f / (HEIGHT - 1)

  r = (bg_top[0] + (bg_bottom[0] - bg_top[0]) * t).to_i
  g = (bg_top[1] + (bg_bottom[1] - bg_top[1]) * t).to_i
  b = (bg_top[2] + (bg_bottom[2] - bg_top[2]) * t).to_i

  img.line(0, y, WIDTH - 1, y, [r, g, b])
end

# ----------------------------
# Floating pastel blobs
# ----------------------------
img.filled_circle(120, 100, 80, accent2)
img.filled_circle(680, 280, 100, accent1)
img.filled_circle(700, 80, 50, [200, 230, 255])

# ----------------------------
# Text
# ----------------------------
font = "/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf"
title_size = 52
subtitle_size = 20

title = "RubyStackNews"
subtitle = "The pulse of the Ruby ecosystem"

# Manual centering
title_x = 80
title_y = 190

# Soft shadow
img.text(title, {
  x: title_x + 2,
  y: title_y + 2,
  size: title_size,
  color: shadow,
  font: font
})

# Main title
img.text(title, {
  x: title_x,
  y: title_y,
  size: title_size,
  color: text_main,
  font: font
})

# Subtitle
img.text(subtitle, {
  x: title_x,
  y: title_y + 45,
  size: subtitle_size,
  color: [100,110,160],
  font: font
})

# ----------------------------
# Call-to-action pill
# ----------------------------
pill_x = 80
pill_y = 260
pill_w = 260
pill_h = 44

img.filled_rectangle(pill_x, pill_y, pill_x + pill_w, pill_y + pill_h, [255,255,255])
img.rectangle(pill_x, pill_y, pill_x + pill_w, pill_y + pill_h, accent2, thickness: 2)

img.text("rubystacknews.com", {
  x: pill_x + 22,
  y: pill_y + 30,
  size: 20,
  color: text_main,
  font: font
})

# ----------------------------
# Save
# ----------------------------
img.save("images/rubystacknews-banner.png")
puts "Saved images/rubystacknews-banner.png"
