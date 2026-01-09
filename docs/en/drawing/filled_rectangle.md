# GD::Image#filled_rectangle

Draws a filled rectangle on the image.

## Signature
```ruby
filled_rectangle(x1, y1, x2, y2, color)
```

## Parameters
- `x1`, `y1`: Top-left corner
- `x2`, `y2`: Bottom-right corner
- `color`: Color allocated via `image.color(r,g,b,a=0)`

## Example
```ruby
img = GD::Image.new(400,300)
red = img.color(255,0,0)
img.filled_rectangle(50,50,200,150,red)
img.save_png("filled_rect.png")
```

## Notes
Maps to `gdImageFilledRectangle`.
