require "gd"

FONT = "/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf"

WIDTH = 640
HEIGHT = 480

img = GD::Image.new(WIDTH, HEIGHT)

white = GD::Color.rgb(255,255,255)
black = GD::Color.rgb(0,0,0)

colors = [
  GD::Color.rgb(31,119,180),   # Frogs (blue)
  GD::Color.rgb(214,39,40),    # Logs (red)
  GD::Color.rgb(44,160,44),    # Dogs (green)
  GD::Color.rgb(255,127,14)    # Hogs (orange)
]

labels = ["Frogs","Logs","Dogs","Hogs"]
values = [15,10,45,30]

img.filled_rectangle(0,0,WIDTH,HEIGHT,white)

cx = WIDTH/2
cy = HEIGHT/2
radius = 180

total = values.sum.to_f
start_angle = 0.0

values.each_with_index do |v,i|
  sweep = v / total * 360.0

  img.filled_arc(
    cx, cy,
    radius*2, radius*2,
    start_angle,
    start_angle + sweep,
    colors[i]
  )

  start_angle += sweep
end

# Outline
img.ellipse(cx,cy,radius*2,radius*2,black)

# Labels
start_angle = 0.0
values.each_with_index do |v,i|
  angle = (start_angle + (v/total*360)/2) * Math::PI/180

  lx = cx + Math.cos(angle)*(radius + 20)
  ly = cy + Math.sin(angle)*(radius + 20)

  img.text(labels[i],{
    x: lx.to_i - 10,
    y: ly.to_i,
    size: 14,
    color: black,
    font: FONT
  })

  start_angle += v/total*360
end

img.save("images/pie_chart.png")
puts "Saved images/pie_chart.png"
