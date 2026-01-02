# Ruby Libgd

<p align="right">
  <img src="logo.png" width="160" />
</p>

**Native Ruby bindings for the GD graphics library**

`ruby-libgd` is a fast, native Ruby wrapper around **libgd** providing image creation, drawing primitives, filters, alpha blending, and transformations — without external binaries like ImageMagick.

It is designed to be lightweight, embeddable, and suitable for web applications, automation, and graphics pipelines.

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

img.filled_rect(0,0,600,400, white)
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

img.filled_rect(0,0,300,300, bg)
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
img.rect(50,50,350,350, blue)
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

## Why ruby-libgd?

Unlike ImageMagick-based solutions, ruby-libgd runs inside your Ruby process with:

- no shell calls
- no temporary files
- no external binaries
- predictable performance

It is ideal for:

- web image generation
- thumbnails
- badges
- charts
- server-side graphics
- data visualization

## License

MIT License.
Copyright (c) 2025 Germán Alberto Giménez Silva.
