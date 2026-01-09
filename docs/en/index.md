# ruby-libgd — Graphics & Image Processing for Ruby

`ruby-libgd` provides a native 2D raster graphics engine for Ruby based on the GD C library.
It exposes a complete drawing, text, filtering, composition and image I/O API through the `GD::Image` class.

---

## Core Classes

| Class | Description |
|------|-------------|
| `GD::Image` | Raster image canvas and all drawing, filtering and export operations |

---

## Canvas & Core

| Method | Description |
|--------|-------------|
| `GD::Image.new` | Create a new truecolor canvas |
| `GD::Image.new_true_color` | Create a new truecolor image |
| `GD::Image.open` | Load an image from disk |
| `width` | Image width |
| `height` | Image height |
| `color` | Allocate a color (RGBA) |
| `alpha_blending=` | Enable / disable alpha blending |
| `save_alpha=` | Enable / disable alpha channel saving |
| `clone` | Duplicate the image |

---

## Color

| Method | Description |
|--------|-------------|
| `GD::Color.rgb` | Create an RGB color |
| `GD::Color.rgba` | Create an RGBA color |

---

## Drawing

| Method | Description |
|-------|-------------|
| `line` | Draw a straight line |
| `rectangle` | Draw a rectangle outline |
| `filled_rectangle` | Draw a filled rectangle |
| `ellipse` | Draw an ellipse |
| `filled_ellipse` | Draw a filled ellipse |
| `circle` | Draw a circle with thickness |
| `filled_circle` | Draw a filled circle |
| `polygon` | Draw a polygon |
| `filled_polygon` | Draw a filled polygon |

---

## Text

| Method | Description |
|--------|-------------|
| `text` | Draw UTF-8 TrueType text |

---

## Filters

| Method | Description |
|--------|-------------|
| `filter("negate")` | Invert colors |
| `filter("grayscale")` | Convert to grayscale |
| `filter("brightness", v)` | Adjust brightness |
| `filter("contrast", v)` | Adjust contrast |
| `filter("colorize", r,g,b,a)` | Color overlay |
| `filter("sepia")` | Sepia tone (ruby-libgd) |

---

## Transformations

| Method | Description |
|--------|-------------|
| `crop` | Crop to a new image |
| `scale` | Resize to a new image |
| `resize` | Alias for `scale` |
| `clone` | Duplicate the image |

---

## Composition

| Method | Description |
|--------|-------------|
| `copy` | Copy a region from another image |
| `copy_resize` | Copy & resize (optionally resampled) |

---

## Input & Output

| Method | Description |
|--------|-------------|
| `GD::Image.open` | Load an image |
| `save` | Save to PNG / JPEG / WebP |
| `to_png` | Encode to PNG and return bytes |


