# text_ft

Renders TrueType or OpenType text using FreeTypeEx, providing high-quality, DPI-aware typography.

This method is an advanced alternative to `text`, exposing FreeType features such as multiline layout, line spacing, DPI control, and rotation.

---

## Syntax

```ruby
image.text_ft(text, x:, y:, font:, size:, color:, angle: 0.0, dpi: 96, line_spacing: 1.0)
```
## Parameters

| Name | Type | Description |
| ---- | ---- | ---- |
| text | String | UTF-8 text to draw |
| x | Integer | X position (baseline) |
| y | Integer | Y position (baseline) |
| font | String | Path to a TrueType or OpenType font |
| size | Numeric | Font size in points |
| color | Array | [R, G, B] or [R, G, B, A] |
| angle | Float | Rotation in radians (default 0.0) |
| dpi | Integer | Horizontal and vertical resolution (default 96) |
| line_spacing | Float | Multiline spacing multiplier (default 1.0) |

### Example
```ruby
img.text_ft(
  "Tokyo\nShinjuku",
  x: 100,
  y: 150,
  font: "NotoSans-Regular.ttf",
  size: 28,
  color: [255,255,255],
  dpi: 144,
  line_spacing: 1.4
)
```
### Rotation

```ruby

img.text_ft(
  "Route 66",
  x: 200,
  y: 200,
  font: "NotoSans-Bold.ttf",
  size: 24,
  color: [0,0,0],
  angle: Math::PI / 6
)
```

**Notes**
text_ft uses gdImageStringFTEx internally.


