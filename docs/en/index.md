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
| [`GD::Image.new`](io/new.md) | Create a new truecolor canvas |
| [`GD::Image.open`](io/load.md) | Load an image from disk |
| [`width`](core/width.md) | Image width |
| [`height`](core/height.md) | Image height |
| [`color`](core/color.md) | Allocate a color (RGBA) |
| [`clone`](transform/clone.md) | Duplicate the image |
| [`destroy`](core/destroy.md) | Free image memory |

---

## Color

| Method | Description |
|--------|-------------|
| [`GD::Color.rgb`](color/rgb.md) | Create an RGB color |
| [`GD::Color.rgba`](color/rgba.md) | Create an RGBA color |
| [`GD::Color`](color/model.md) | Color model |

---

## Drawing

| Method | Description |
|-------|-------------|
| [`line`](drawing/line.md) | Draw a straight line |
| [`rectangle`](drawing/rectangle.md) | Draw a rectangle outline |
| [`filled_rectangle`](drawing/filled_rectangle.md) | Draw a filled rectangle |
| [`ellipse`](drawing/ellipse.md) | Draw an ellipse |
| [`filled_ellipse`](drawing/filled_ellipse.md) | Draw a filled ellipse |
| [`circle`](drawing/circle.md) | Draw a circle |
| [`filled_circle`](drawing/filled_circle.md) | Draw a filled circle |
| [`polygon`](drawing/polygon.md) | Draw a polygon |
| [`filled_polygon`](drawing/filled_polygon.md) | Draw a filled polygon |

---

## Text

| Method | Description |
|--------|-------------|
| [`text`](text/text.md) | Draw UTF-8 TrueType text |

---

## Filters

| Method | Description |
|--------|-------------|
| [`filter`](filters/filter.md) | Apply a GD image filter |
| [`filter("sepia")`](filters/sepia.md) | Native sepia tone (ruby-libgd) |

---

## Transformations

| Method | Description |
|--------|-------------|
| [`crop`](transform/crop.md) | Crop to a new image |
| [`scale`](transform/scale.md) | Resize to a new image |
| [`resize`](transform/resize.md) | Alias for scale |
| [`clone`](transform/clone.md) | Duplicate the image |

---

## Composition

| Method | Description |
|--------|-------------|
| [`copy`](composition/copy.md) | Copy a region from another image |
| [`copy_resize`](composition/copy_resize.md) | Copy & resize (optionally resampled) |

---

## Input & Output

| Method | Description |
|--------|-------------|
| [`GD::Image.new`](io/new.md) | Create a blank image |
| [`GD::Image.open`](io/load.md) | Load from file |
| [`save`](io/save.md) | Save to PNG / JPEG / WebP |
| [`to_png`](io/to_png.md) | Encode to PNG and return bytes |
