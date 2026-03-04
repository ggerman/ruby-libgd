require 'gd'

img = GD::Image.open("images/cat_piano.jpg")

colors = []

100.times do
  x = rand(img.width)
  y = rand(img.height)

  r,g,b,a = img.get_pixel(x,y)

  color = (a << 24) | (r << 16) | (g << 8) | b

  colors << color
end

colors.uniq!

img.filter(:scatter_ex,
  sub: 10,
  plus: 30,
  seed: 99,
  colors: colors
)

img.save("images/scatter_ex-02.jpg")
