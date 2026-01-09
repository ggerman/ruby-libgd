# GD::Image#rectangle

Draws a rectangular outline on the image.

## Signature
```ruby
rectangle(x1, y1, x2, y2, color)
```

## Parameters
- `x1`, `y1`: Top-left corner
- `x2`, `y2`: Bottom-right corner
- `color`: Color allocated via `image.color(r,g,b,a=0)`

## Example
```ruby
img = GD::Image.new(400,300)
red = img.color(255,0,0)
img.rectangle(50,50,200,150,red)
img.save_png("rect.png")
```

## Notes
This method maps directly to the native `gdImageRectangle` function in libgd.
