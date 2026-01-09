# GD::Image#line

Draws a straight line between two points.

## Signature
```ruby
line(x1, y1, x2, y2, color)
```

## Parameters
- `x1`, `y1`: Starting point
- `x2`, `y2`: Ending point
- `color`: Color allocated via `image.color(r,g,b,a=0)`

## Example
```ruby
img = GD::Image.new(400,300)
blue = img.color(0,0,255)
img.line(20,20,380,280,blue)
img.save("line.png")
```

## Notes
This method maps directly to `gdImageLine` in libgd.
