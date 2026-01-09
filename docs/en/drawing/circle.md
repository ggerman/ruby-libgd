# GD::Image#circle

Draws a circle outline with optional stroke thickness.

## Signature
```ruby
circle(cx, cy, radius, color, thickness: 1)
```

## Parameters
- `cx`, `cy`: Center coordinates
- `radius`: Circle radius
- `color`: Color allocated via `image.color`
- `thickness`: Optional stroke thickness

## Example
```ruby
img = GD::Image.new(300,300)
red = img.color(255,0,0)
img.circle(150,150,60,red, thickness: 3)
img.save("circle.png")
```

## Notes
Implemented natively in ruby-libgd using `gdImageArc` for stroke thickness support.
