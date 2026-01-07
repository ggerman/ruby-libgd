# Changelog

All notable changes to this project will be documented in this file.  
This project follows semantic versioning.
---

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
