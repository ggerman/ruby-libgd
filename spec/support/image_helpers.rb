require "chunky_png"

def img(path)
  ChunkyPNG::Image.from_file(path)
end

def px(path, x, y)
  img(path)[x,y]
end

def rgb(color)
  [
    ChunkyPNG::Color.r(color),
    ChunkyPNG::Color.g(color),
    ChunkyPNG::Color.b(color)
  ]
end
