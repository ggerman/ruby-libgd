# GD::Image#filter

Applies a pixel-level filter to the image.

## Signature
```ruby
filter(type, *args)
```

## Supported filters

### negate
```ruby
img.filter("negate")
```
Inverts image colors.

### grayscale
```ruby
img.filter("grayscale")
```
Converts the image to grayscale.

### brightness
```ruby
img.filter("brightness", value)
```
- `value`: Integer (negative to darken, positive to brighten)

### contrast
```ruby
img.filter("contrast", value)
```
- `value`: Integer (negative/positive depending on libgd behavior)

### colorize
```ruby
img.filter("colorize", r, g, b, a)
```
Applies a color overlay.
- `r`, `g`, `b`: 0..255
- `a`: 0..127 (GD alpha)

### sepia
```ruby
img.filter("sepia")
```
Applies a sepia tone. Implemented in ruby-libgd.

## Notes
The underlying implementation maps to libgd filters where available; `sepia` is provided by ruby-libgd.
