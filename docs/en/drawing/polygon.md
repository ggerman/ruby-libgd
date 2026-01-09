# GD::Image#polygon

Draws a polygon outline using a list of points.

## Signature
```ruby
polygon(points, color)
```

## Parameters
- `points`: Array of `[x,y]` pairs
- `color`: Color allocated via `image.color`

## Example
```ruby
pts = [[50,50],[150,50],[100,120]]
img.polygon(pts, img.color(0,0,0))
```
