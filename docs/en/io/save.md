# GD::Image#save

Saves the image to disk. The output format is inferred from the file extension.

## Signature
```ruby
save(path, options = nil)
```

## Supported formats
| Extension | Backend |
|-----------|---------|
| .png | PNG with alpha |
| .jpg, .jpeg | JPEG (quality supported) |
| .webp | WebP |

## Options
- `quality` (Integer, JPEG only, default: 90)

## Examples
```ruby
img.save("map.png")
img.save("photo.jpg", quality: 80)
img.save("tile.webp")
```

## Errors
Raises `ArgumentError` for unsupported extensions.
