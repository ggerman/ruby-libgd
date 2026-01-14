# text_bbox

Returns the pixel bounding box of a TrueType string rendered with FreeType.

This method allows you to measure the exact width and height of a string before drawing it, enabling layout, centering, background boxes, and collision detection.

Unlike simple font metrics, `text_bbox` uses the same FreeType engine as actual rendering, so the result matches exactly what will be drawn.

---

## Syntax

```ruby
width, height = image.text_bbox(text, font:, size:, angle: 0.0)
```
### Parameters
| Name | Type | Description |
| ---- | ---- | ---- |
|text | String | UTF-8 string to measure |
| font | String | Path to a TrueType or OpenType font  |
| size | Numeric | Font size in points |
| angle | Float | Optional rotation in radians (default: 0.0 )|

Example
```ruby
w, h = img.text_bbox(
  "Tokyo",
  font: "NotoSans-Bold.ttf",
  size: 32
)

img.filled_rectangle(
  100, 100,
  100 + w + 20, 100 + h + 20,
  [0, 0, 0, 120]
)

img.text(
  "Tokyo",
  x: 110,
  y: 110 + h,
  font: "NotoSans-Bold.ttf",
  size: 32,
  color: [255,255,255]
)
```

Notes
The bounding box accounts for glyph shapes, kerning, and hinting.

Rotation is fully supported.

The result is consistent with text_ft, making it suitable for GIS labels and layout engines.