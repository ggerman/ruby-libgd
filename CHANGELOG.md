# Changelog

All notable changes to this project will be documented in this file.  
This project follows semantic versioning.

---

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
