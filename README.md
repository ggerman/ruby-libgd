# Ruby Libgd

<p align="right">
  <img src="docs/images/logo.png" width="160" />
</p>


**Native Ruby bindings for the GD graphics library**

`ruby-libgd` is a fast, native Ruby wrapper around **libgd** providing image creation, drawing primitives, filters, alpha blending, and transformations — without external binaries like ImageMagick.

It is designed to be lightweight, embeddable, and suitable for web applications, automation, and graphics pipelines.

[rubystacknews.com](https://rubystacknews.com/2026/01/02/rebuilding-rubys-image-processing-layer-why-ruby-libgd-matters-for-gis-and-the-future-of-ruby/)

---

## Features

- Native C bindings to libgd  
- PNG, JPEG, WEBP support  
- RGBA colors and real alpha transparency  
- Drawing primitives: lines, rectangles, circles, polygons, arcs  
- Image filters: blur, brightness, grayscale, pixelate, etc  
- Composition: clone, copy\_merge  
- Transformations: crop, scale, resize  
- No external processes (no ImageMagick, no CLI tools)

---

## Installation

```bash
gem install ruby-libgd
```

## Quick start

```ruby
require "gd"

img = GD::Image.new(600,400)

white = GD::Color.rgb(255,255,255)
red   = GD::Color.rgb(180,0,0)
blue  = GD::Color.rgb(0,120,255)

img.filled_rectangle(0,0,600,400, white)
img.filled_circle(300,200,120, red)
img.arc(300,200,240,240,0,360, blue)

img.save("example.png")
```
## Working with transparency (RGBA)

```ruby
require "gd"

img = GD::Image.new(300,300)
img.save_alpha = true
img.alpha_blending = true

bg = GD::Color.rgba(0,0,0,127)      # fully transparent
red = GD::Color.rgba(255,0,0,64)    # semi-transparent red

img.filled_rectangle(0,0,300,300, bg)
img.filled_circle(150,150,100, red)

img.save("alpha.png")

```

## Loading and modifying images

```ruby
require "gd"

img = GD::Image.open("photo.jpg")

puts img.width
puts img.height

img.filter(:grayscale)
img.filter(:brightness, 20)

img.save("processed.jpg")
```

## Cropping and resizing

```ruby
require "gd"

img = GD::Image.open("photo.jpg")

thumb = img.crop(100,100,300,300)
thumb = thumb.resize(200,200)

thumb.save("thumb.png")
```

## Compositing images

```ruby
base = GD::Image.open("background.png")
overlay = GD::Image.open("logo.png")

overlay.filter(:gaussian_blur)
overlay.filter(:brightness, 40)

base.copy_merge(overlay, 50,50, 0,0, overlay.width, overlay.height, 70)
base.save("merged.png")
```

## Drawing primitives

```ruby
require "gd"

img = GD::Image.new(400,400)

blue  = GD::Color.rgb(0,120,255)
green = GD::Color.rgb(0,200,120)

img.line(50,50,350,350, blue)
img.rectangle(50,50,350,350, blue)
img.filled_circle(200,200,80, green)

poly = [
  [200,50],
  [350,200],
  [200,350],
  [50,200]
]
img.filled_polygon(poly, GD::Color.rgb(240,200,0))

img.save("shapes.png")
```



## Gradient Fan Rendering Example

```Ruby
require "gd"

WIDTH  = 400
HEIGHT = 500

img = GD::Image.new(WIDTH, HEIGHT)

# Colores del degradé
r1, g1, b1 = 255, 40, 40
r2, g2, b2 = 40,  40, 255

k_max = WIDTH + HEIGHT - 2

(0..k_max).each do |k|
  t = k.to_f / k_max

  r = (r1 + (r2 - r1) * t).round
  g = (g1 + (g2 - g1) * t).round
  b = (b1 + (b2 - b1) * t).round

  color = GD::Color.rgb(r, g, b)

  x0 = [0, k - (HEIGHT - 1)].max
  x1 = [WIDTH - 1, k].min

  # extremos del segmento x + y = k dentro del rectángulo
  y0 = k - x0
  y1 = k - x1

  img.line(x0, y0, x1, y1, color)
end

img.save("full_fan_gradient.png")

```



![Full Fan Gradient](./docs/images/full_fan_gradient.png)

## Native Raster Text Rendering in Ruby: Gradient Backgrounds and FreeType Labels

```ruby
require "gd"

WIDTH  = 800
HEIGHT = 400

img = GD::Image.new(WIDTH, HEIGHT)

# ----------------------------
# Colors
# ----------------------------
black = [0, 0, 0]
white = [255, 255, 255]

# Gradient colors (Ruby red)
top = [255, 106, 7]
bottom = [38, 104, 109]

# ----------------------------
# Draw background gradient
# ----------------------------
(0...HEIGHT).each do |y|
  t = y.to_f / (HEIGHT - 1)

  r = (top[0] + (bottom[0] - top[0]) * t).to_i
  g = (top[1] + (bottom[1] - top[1]) * t).to_i
  b = (top[2] + (bottom[2] - top[2]) * t).to_i

  img.line(0, y, WIDTH - 1, y, [r, g, b])
end

# ----------------------------
# Text parameters
# ----------------------------
font = "./fonts/DejaVuSans-Bold.ttf"
size = 40
text = "RubyStackNews.com"

# Approximate centering
text_width  = (text.length * size * 0.6).to_i
text_height = size

x = (WIDTH  - (text_width + 20) )  / 3
y = (HEIGHT + (text_height + 20) ) / 3

# ----------------------------
# Shadow
# ----------------------------
img.text(text,
  x: x + 2,
  y: y + 2,
  size: size,
  color: black,
  font: font
)

# ----------------------------
# Main text
# ----------------------------
img.text(text,
  x: x,
  y: y,
  size: size,
  color: white,
  font: font
)

# ----------------------------
# Save
# ----------------------------
img.save("rubystacknews-banner.png")

puts "Generated rubystacknews-banner.png"
require "gd"

WIDTH  = 800
HEIGHT = 400

img = GD::Image.new(WIDTH, HEIGHT)

# ----------------------------
# Gradient background
# ----------------------------
top    = [120, 0, 0]
bottom = [255, 60, 60]

(0...HEIGHT).each do |y|
  t = y.to_f / (HEIGHT - 1)

  r = (top[0] + (bottom[0] - top[0]) * t).to_i
  g = (top[1] + (bottom[1] - top[1]) * t).to_i
  b = (top[2] + (bottom[2] - top[2]) * t).to_i

  img.line(0, y, WIDTH - 1, y, GD::Color.rgb(r, g, b))
end

# ----------------------------
# Text parameters
# ----------------------------
font = "./fonts/DejaVuSans-Bold.ttf"
size = 48
text = "RubyStackNews.com"

# Aproximación razonable del ancho del texto
# DejaVuSans-Bold es ~0.6 * font_size por carácter
text_width = (text.length * size * 0.6).to_i
text_height = size

x = (WIDTH  - text_width)  / 2
y = (HEIGHT + text_height) / 2

# ----------------------------
# Shadow
# ----------------------------
img.text(text,
  x: x + 2,
  y: y + 2,
  size: size,
  color: :black,
  font: font
)

# ----------------------------
# Main text
# ----------------------------
img.text(text,
  x: x,
  y: y,
  size: size,
  color: :white,
  font: font
)

# ----------------------------
# Save
# ----------------------------
img.save("rubystacknews-banner.png")
puts "Generated rubystacknews-banner.png"

```

![rubystacknews](./docs/images/rubystacknews-banner.png)

---

## Build & Runtime Environment

**ruby-libgd** is developed and tested against **libgd 2.3.3** using a reproducible Docker environment.

This ensures that the native extension is compiled against a known, stable GD ABI and behaves consistently across systems.

Reference **Dockerfile**
```dockerfile
FROM ruby:3.3

RUN apt update && apt -y upgrade
RUN apt install -y \
  libgd-dev \
  libgd3 \
  libgd-tools \
  pkg-config \
  ruby-dev \
  build-essential \
  valgrind

RUN printf "prefix=/usr\n\
exec_prefix=\${prefix}\n\
libdir=\${exec_prefix}/lib/x86_64-linux-gnu\n\
includedir=\${prefix}/include\n\
\n\
Name: gd\n\
Description: GD Graphics Library\n\
Version: 2.3\n\
Libs: -L\${libdir} -lgd\n\
Cflags: -I\${includedir}\n" \
> /usr/lib/x86_64-linux-gnu/pkgconfig/gd.pc

ENV PKG_CONFIG_PATH=/usr/lib/x86_64-linux-gnu/pkgconfig

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

# Enforce dependency lockfile reproducibility
RUN bundle config --global frozen 1

COPY . .

```

## Why this matters

**ruby-libgd** is a native **C** extension. The exact **libgd** version and build flags directly affect:

- Alpha blending

- Color accuracy

- Filter behavior

- Memory safety


Using a pinned, containerized build environment guarantees that:

- The extension is compiled against libgd 2.3.x

- pkg-config resolves the correct headers and linker flags

- CI, contributors, and users see identical behavior


This is especially important for GIS, map tiles, and image pipelines where pixel-level consistency matters.

## License

MIT License.
Copyright (c) 2025 Germán Alberto Giménez Silva.
