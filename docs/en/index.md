<header>
  <img src="../images/logo.png" height="250" alt="ruby-libgd" />
  <h1>Ruby can create images again</h1>
  <p class="lead">
    ruby-libgd is a modern native Ruby binding to the GD Graphics Library —
    a fast, embeddable raster engine for charts, dashboards, GIS, and scientific graphics.
  </p>

  <div class="buttons">
    <a href="https://github.com/ggerman/ruby-libgd">GitHub</a>
    <a class="secondary" href="https://rubygems.org/gems/ruby-libgd">RubyGems</a>
    <a class="secondary" href="https://rubystacknews.com/2026/01/05/ruby-can-create-images-again/">Read the story</a>
  </div>
</header>

<div class="connect-bar">
  <h3>Connect</h3>
  <div class="connect-links">
    <a href="mailto:ggerman@gmail.com" style="color:#1e40af;">📧 Email</a>
    <a href="https://wa.me/5493434192620" target="_blank" style="color:#059669;">💬 WhatsApp</a>
    <a href="https://rubystacknews.com" target="_blank" style="color:#7c3aed;">🌐 RubyStackNews</a>
    <a href="https://x.com/ruby_stack_news" target="_blank" style="color:#0284c7;">🐦 Twitter</a>
    <a href="https://www.linkedin.com/in/germ%C3%A1n-silva-56a12622/" target="_blank" style="color:#0a66c2;">💼 LinkedIn</a>
  </div>
</div>

<div class="connect-bar">
  <h3>Documentation</h3>
  <div class="connect-links">
    <a href="/ruby-libgd/index.html">🇬🇧 English</a>
    <a href="/ruby-libgd/jp/index.html">🇯🇵 日本語</a>
    <a href="https://github.com/ggerman/ruby-libgd">📦 GitHub</a>
    <a href="https://rubygems.org/gems/ruby-libgd">💎 RubyGems</a>
  </div>
</div>

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
| [antialias](antialiasing.md) | Antialiasing & Alpha Blending |

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
