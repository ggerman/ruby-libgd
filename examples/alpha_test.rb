require "gd"

WIDTH  = 800
HEIGHT = 400

img = GD::Image.new(WIDTH, HEIGHT)

# Fondo
img.alpha_blending = true
img.save_alpha = true

# Fondo gris claro
bg = GD::Color.rgb(240,240,240)
img.filled_rectangle(0,0,WIDTH,HEIGHT,bg)

# Cruz de referencia
img.line(0, HEIGHT/2, WIDTH, HEIGHT/2, GD::Color.rgb(200,200,200))
img.line(WIDTH/2, 0, WIDTH/2, HEIGHT, GD::Color.rgb(200,200,200))

# Líneas semitransparentes
img.line(50,50,750,350, GD::Color.rgba(255,0,0,128), thickness: 12)
img.line(50,350,750,50, GD::Color.rgba(0,0,255,128), thickness: 12)

# Rectángulos con alpha
img.rectangle(100,100,700,300, GD::Color.rgba(0,200,0,100))

# Texto con alpha
img.text(
  "Alpha blending test",
  x: 200,
  y: 220,
  size: 28,
  font: "./DejaVuSans.ttf",
  color: GD::Color.rgba(0,0,0,120)
)

img.save("alpha_test.png")
puts "Generated alpha_test.png"
