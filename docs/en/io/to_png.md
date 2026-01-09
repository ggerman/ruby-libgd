# GD::Image#to_png

Encodes the image as PNG and returns the binary string.

## Signature
```ruby
to_png -> String
```

## Example
```ruby
data = img.to_png
File.binwrite("out.png", data)
```
