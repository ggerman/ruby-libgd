## [Unreleased]

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
