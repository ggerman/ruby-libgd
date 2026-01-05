require "gd"

FONT = "/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf"

WIDTH  = 640
HEIGHT = 480
MARGIN = 70

img = GD::Image.new(WIDTH, HEIGHT)

# Colors
white = GD::Color.rgb(255,255,255)
black = GD::Color.rgb(0,0,0)
africa   = GD::Color.rgb(70,130,180)
americas = GD::Color.rgb(255,165,0)
asia     = GD::Color.rgb(50,180,90)
europe   = GD::Color.rgb(220,70,70)
oceania  = GD::Color.rgb(160,120,200)
grid     = GD::Color.rgb(220,220,220)

img.filled_rectangle(0,0,WIDTH,HEIGHT, white)

years = [1950,1960,1970,1980,1990,2000,2010,2020]
africa_data   = [0.23,0.28,0.36,0.48,0.64,0.82,1.05,1.34]
americas_data = [0.34,0.42,0.52,0.62,0.74,0.89,1.02,1.20]
asia_data     = [1.40,1.60,2.10,2.60,3.20,3.70,4.20,4.60]
europe_data   = [0.55,0.60,0.65,0.69,0.72,0.73,0.74,0.75]
oceania_data  = [0.01,0.02,0.03,0.03,0.03,0.04,0.04,0.05]

max_pop = 7.5

chart_w = WIDTH - 2*MARGIN
chart_h = HEIGHT - 2*MARGIN

# Axes
img.line(MARGIN, MARGIN, MARGIN, HEIGHT - MARGIN, black, thickness: 2)
img.line(MARGIN, HEIGHT - MARGIN, WIDTH - MARGIN, HEIGHT - MARGIN, black, thickness: 2)

# Y grid
(0..7).each do |i|
  y = HEIGHT - MARGIN - (i * chart_h / 7)
  img.line(MARGIN, y, WIDTH - MARGIN, y, grid)
  img.text(i.to_s, {
    x: MARGIN - 30,
    y: y + 5,
    size: 12,
    color: black,
    font: FONT
  })
end

# X labels
years.each_with_index do |year, i|
  x = MARGIN + i * chart_w / (years.size - 1)
  img.text(year.to_s, {
    x: x - 15,
    y: HEIGHT - MARGIN + 25,
    size: 12,
    color: black,
    font: FONT
  })
end

# Draw stacked areas
layers = [
  africa_data,
  americas_data,
  asia_data,
  europe_data,
  oceania_data
]
colors = [africa, americas, asia, europe, oceania]

cumulative = Array.new(years.size, 0.0)

layers.each_with_index do |layer, idx|
  poly = []

  # top line
  layer.each_with_index do |v,i|
    cumulative[i] += v
    x = MARGIN + i * chart_w / (years.size - 1)
    y = HEIGHT - MARGIN - (cumulative[i] / max_pop) * chart_h
    poly << [x,y]
  end

  # bottom line (reverse)
  (years.size - 1).downto(0) do |i|
    x = MARGIN + i * chart_w / (years.size - 1)
    y = HEIGHT - MARGIN - ((cumulative[i] - layer[i]) / max_pop) * chart_h
    poly << [x,y]
  end

    img.filled_polygon(poly, colors[idx])
    img.polygon(poly, black)
end

# Title
img.text("World population", {
  x: WIDTH/2 - 80,
  y: 35,
  size: 18,
  color: black,
  font: FONT
})

# Legend
legend_x = WIDTH - 170
legend_y = 80

["Africa","the Americas","Asia","Europe","Oceania"].each_with_index do |name,i|
  img.filled_rectangle(legend_x, legend_y + i*25, legend_x+20, legend_y+20+i*25, colors[i])
  img.text(name,{
    x: legend_x + 30,
    y: legend_y + 15 + i*25,
    size: 12,
    color: black,
    font: FONT
  })
end

img.save("images/world_population.png")
puts "Saved images/world_population.png"
