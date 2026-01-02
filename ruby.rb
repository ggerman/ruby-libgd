require "gd"

SIZE = 600
img = GD::Image.new(SIZE,SIZE)
# img = GD::Image.open("tmp/photo.jpg")

white = GD::Color.rgb(255,255,255)
img.fill(white)

ruby_red = GD::Color.rgb(180,0,0)

# Ruby gem main shape (simplified polygon)
ruby_shape = [
  [300,50],[380,80],[450,160],[500,280],
  [460,380],[380,460],[300,500],[220,460],
  [140,380],[100,280],[150,160],[220,80]
]

=begin
ruby_shape = [
  [200,200],
  [400,200],
  [450,300],
  [300,450],
  [150,300]
]
=end

img.filled_polygon(ruby_shape, ruby_red)
highlight = img.clone

# img.polygon(ruby_shape, ruby_red)
# Inner highlight
# highlight.filter(:gaussian_blur)
# highlight.filter(:brightness, 40)
img.copy_merge(highlight, 0,0, 0,0, SIZE,SIZE, 40)

=begin
# Shadow
shadow = img.clone
shadow.filter(:gaussian_blur)
shadow.filter(:brightness, -50)
img.copy_merge(shadow, 5,10, 0,0, SIZE,SIZE, 50)

# Shine
shine = GD::Image.new(SIZE,SIZE)
shine.fill(GD::Color.rgb(0,0,0))
shine.filled_circle(250,200,120, GD::Color.rgb(255,255,255))
shine.filter(:gaussian_blur)
img.copy_merge(shine, 0,0, 0,0, SIZE,SIZE, 30)

# Final polish
img.filter(:contrast, -20)
img.filter(:smooth, 20)
=end

img.save("ruby_logo.png")
puts "Generated ruby_logo.png"

