# GD::Image#text

Draws text on the image using a TrueType font.

## Signature
```ruby
text(string, x:, y:, size:, color:, font:)
```

## Parameters
- `string`: UTF-8 text to render
- `x`, `y`: Baseline position (y is the text baseline, not the top)
- `size`: Font size in points
- `color`: Color allocated via `image.color` / `GD.rgba`
- `font`: Path to a `.ttf` font file

## Example
```ruby
img = GD::Image.new(400,200)
black = img.color(0,0,0)

img.text(
  "Hello Ruby",
  x: 20, y: 100,
  size: 24,
  color: black,
  font: "./fonts/DejaVuSans.ttf"
)

img.save("text.png")
```

## Notes
- Uses libgd FreeType renderer (antialiasing + UTF-8).
- If text looks “cut”, adjust `y` (baseline) and/or add padding around the canvas.
