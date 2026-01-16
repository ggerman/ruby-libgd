# add_frame

```ruby
gif.add_frame(image, delay: 50)
```

Adds a frame to the animated GIF.

---

## Overview

`add_frame` takes a rendered `GD::Image` and appends it
as a frame in the animated GIF.

Frames are played back in the order they are added.

---

## Parameters

### `image` (`GD::Image`)

The image to use as a frame.

```ruby
img = GD::Image.new(200, 200)
gif.add_frame(img)
```

---

### `delay` (`Integer`, optional)

The duration each frame is displayed.

- Unit: 1/100 second (centiseconds)
- Default: `50` (0.5 seconds)

```ruby
gif.add_frame(img, delay: 10)
```

---

## Behavior

- The GIF header is written when the first frame is added
- Frames are encoded as deltas against the previous frame
- Each frame internally references the previous one

---

## Notes

- All frames must have identical dimensions
- Adding frames of different sizes may produce invalid output
- The GIF is not complete until `close` is called

---

## Example

```ruby
gif = GD::Gif.new("animation.gif")

10.times do |i|
  img = GD::Image.new(200, 200)

  img.filled_circle(
    100,
    100,
    20 + i * 5,
    GD::Color.rgb(255, 0, 0)
  )

  gif.add_frame(img, delay: 5)
end

gif.close
```

---

## Related Methods

- [`GD::Gif.new`](new.md)
- [`close`](close.md)
