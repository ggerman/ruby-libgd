# GD::Image.load

Loads an image from disk.

## Signature
```ruby
GD::Image.load(path)
```

## Supported formats
PNG, JPEG, WebP (based on file contents)

## Example
```ruby
img = GD::Image.load("map.png")
```
