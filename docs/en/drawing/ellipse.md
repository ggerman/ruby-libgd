# GD::Image#ellipse

Draws an ellipse outline on the image.

## Signature
```ruby
ellipse(cx, cy, width, height, color)
```

## Parameters
- `cx`, `cy`: Center point
- `width`: Width of the ellipse
- `height`: Height of the ellipse
- `color`: Color allocated via `image.color(r,g,b,a=0)`

## Example
```ruby
img = GD::Image.new(400,300)
green = img.color(0,255,0)
img.ellipse(200,150,100,80,green)
img.save_png("ellipse.png")
```

## Notes
This method maps to `gdImageEllipse` in libgd.
