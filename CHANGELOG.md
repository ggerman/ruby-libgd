# Changelog

All notable changes to this project will be documented in this file.  
This project follows semantic versioning.
---

---

## **ruby-libgd 0.2.2 — Text & Layout Foundations**

This release significantly expands ruby-libgd’s text rendering capabilities while preserving full backward compatibility with the existing `.text` API.

### **New**

**`GD::Image#text_bbox`**
 Adds support for measuring rendered text using FreeType.
 Returns the exact pixel width and height of a string for layout, centering, and label placement.

```
w, h = img.text_bbox("Tokyo", font: "NotoSans.ttf", size: 32)
```

**`GD::Image#text_ft`**
 Introduces a high-quality FreeType rendering path via `gdImageStringFTEx`, enabling:

- DPI-aware rendering
- Multiline text
- Line spacing control
- Subpixel hinting
- Rotation support

```
img.text_ft(
  "Tokyo\nShinjuku",
  x: 100,
  y: 200,
  font: "NotoSans.ttf",
  size: 28,
  dpi: 144,
  line_spacing: 1.4
)
```

### **Improved**

**Text measurement and layout**

- Text bounding boxes now use the same FreeType engine as rendering, ensuring perfect consistency between measurement and output.
- Rotation-aware bounding boxes are supported for proper placement of angled labels.

**Foundation for GIS labels, UI, and layout engines**

- These new primitives enable:
  - Centered and aligned labels
  - Background boxes
  - Collision detection
  - Map overlays
  - Hi-DPI text for printing and export

### **Compatibility**

- The existing `GD::Image#text` method remains unchanged and fully backward-compatible.
- All new functionality is additive and does not alter existing behavior.

### **Testing**

- Added deterministic FreeType-based specs using a bundled font fixture.
- Ensures stable, cross-platform rendering and layout measurements in CI.

---

## 0.2.0 — January 11, 2026

This release introduces a major upgrade to ruby-libgd’s rendering engine, focused on **truecolor alpha blending and antialiasing**.
 It marks the transition from basic raster output to **modern, high-quality graphics suitable for GIS, charts, and layered visualizations**.

### ✨ New features

- **Truecolor alpha support**
  - Colors now accept `[r, g, b, a]` with `a = 0..255`
  - Correct conversion to GD’s internal alpha range
  - Proper blending of overlapping shapes, text, and layers
- **Antialiasing for all drawing primitives**
  - New `GD::Image#antialias=` API
  - Smooth edges for:
    - lines
    - polygons
    - ellipses and circles
    - filled shapes
    - text
  - Enables professional-grade rendering quality
- **Unified color pipeline**
  - `GD::Color.rgb` and `GD::Color.rgba`
  - Consistent Ruby-level color representation
  - Automatic conversion to GD truecolor or palette formats

### 🖼 Rendering improvements

- Clean curved edges and diagonals
- Correct alpha compositing between layers
- No more jagged borders when drawing with transparency
- Significantly improved visual quality for maps and diagrams

### 🧩 API additions

```
img.antialias = true
GD::Color.rgb(r, g, b)
GD::Color.rgba(r, g, b, a)
```

### 🗺 Impact on libgd-gis

This release provides the rendering foundation required by **libgd-gis**:

- smooth rivers and roads
- readable labels
- layered map styling
- modern GIS-grade output

### ⚠️ Notes

- Alpha values are expressed in Ruby as `0..255`
- Internally converted to GD’s `0..127` range
- Existing RGB color code remains fully compatible

---

# v0.1.8 — RGBA & Alpha Transparency

Added

RGBA color support via GD::Color.rgba(r, g, b, a) for all drawing operations.

True alpha blending for:

Lines

Shapes

Text rendered via FreeType (gdImageStringFT)

Images now preserve the alpha channel when saved, enabling transparent overlays.

Improved

Internal color conversion now maps Ruby RGBA (0–255) to GD’s alpha scale (0–127) correctly.

Both truecolor and palette images support transparency using gdImageColorAllocateAlpha.

Rendering output now supports layered graphics, allowing semi-transparent primitives to blend correctly.

Fixed

Drawing methods (line, text, etc.) no longer reject RGBA colors.

Alpha values are no longer misinterpreted as fully transparent due to scale mismatch.

Text rendering now respects alpha values instead of being forced opaque.

Why this matters

This release upgrades ruby-libGD from basic raster drawing to a modern compositing engine.
It enables real-world use cases such as:

Transparent overlays

Heatmaps

GIS layers

Labeling over basemaps

Data visualization pipelines

This is a foundational step toward using ruby-libGD for map rendering, dashboards, and scientific graphics.

## [0.1.7] — 2026-01-07

### Added
- **High-quality image scaling via `copy_resize`**
  - New `GD::Image#copy_resize` method for resizing and copying image regions.
  - Supports both:
    - `gdImageCopyResized` (fast, nearest-neighbor)
    - `gdImageCopyResampled` (high-quality resampling)

  ```ruby
  dst.copy_resize(
    src,
    dst_x, dst_y,
    src_x, src_y,
    src_w, src_h,
    dst_w, dst_h,
    true   # enable high-quality resampling
  )


## **v0.1.6 — Sepia filter & color-pipeline expansion**

**Release date:** 2026-01-05

This release introduces **native sepia rendering** and continues the expansion of ruby-libgd into a full **image processing and raster graphics engine**.

### ✨ New features

**Native sepia filter**

- Added `image.filter(:sepia)` — a true pixel-level sepia transformation
- Implemented in C using a color-matrix transform (no ImageMagick, no external tools)
- Produces consistent photographic-grade sepia tones

**New example**

- Added a runnable example demonstrating:
  - loading an image
  - applying sepia
  - saving the transformed result

This example serves as both documentation and a regression test for the filter pipeline.

------

### 🔧 Technical details

- Sepia is implemented as a raster-space color matrix applied per pixel:

  ```
  R' = 0.393R + 0.769G + 0.189B
  G' = 0.349R + 0.686G + 0.168B
  B' = 0.272R + 0.534G + 0.131B
  ```

- Integrated into the existing `image.filter(...)` dispatcher

- No dependency on libgd filters — this is a native ruby-libgd extension

------

### 🚀 Why this matters

With sepia added, ruby-libgd now supports:

- grayscale
- brightness
- contrast
- blur
- pixelation
- edge detection
- **photographic color transforms**

This moves the project beyond bindings and into the territory of a **modern Ruby image processing engine**, suitable for:

- dashboards
- reports
- map tiles
- historical GIS rendering
- photo pipelines


## [0.1.5] – Native CI, Drawing API fixes

### 🚀 Infrastructure

**Native C-Extension Continuous Integration**

ruby-libgd now includes a full native CI pipeline that builds, installs, and tests the gem exactly the same way real users do:

- The gem is built via `gem build`
- Installed via `gem install`
- Linked against system `libgd`
- Tested using RSpec against the installed gem (not the source tree)

This guarantees:

- `gd/gd.so` is correctly packaged
- `require "gd"` works in real environments
- No false positives from Bundler or path-based loading
- Docker, CI, and production behave the same

This moves ruby-libgd to **production-grade native gem** status.

---

### 🎨 Drawing API

#### **Line Thickness Support**

Line thickness is now correctly propagated to libgd:

```ruby
img.thickness(4)
img.line(10, 10, 200, 200, color)
```

## [0.1.3] – Native CI, Drawing API fixes

### Added
Exposed the native `gdImageCopy` function to Ruby as `GD::Image#copy(src, dx, dy, sx, sy, w, h)`.

This enables true raster composition between images, allowing tiles and image regions to be copied into a destination canvas.  
This operation is a fundamental building block for:

- Tile stitching
- Image mosaics
- Layer compositing
- GIS and map tile rendering pipelines

The method was registered with the correct Ruby 3.3 arity (7 arguments), ensuring ABI compatibility and preventing dispatch errors during compilation.

This change allows ruby-libgd to be used as a full raster rendering engine rather than a single-image manipulation library.
