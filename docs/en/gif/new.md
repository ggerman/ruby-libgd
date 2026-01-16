# GD::Gif.new

```ruby
gif = GD::Gif.new("output.gif", loop: true)
```

Creates a new animated GIF writer.

---

## Overview

`GD::Gif.new` initializes a GIF encoder used to generate animated GIFs.

At this stage, the output file is created, but no image data is written
until frames are added.

---

## Parameters

### `path` (`String`)

The file path where the GIF will be written.

```ruby
GD::Gif.new("animation.gif")
```

---

### `loop` (`Boolean`, optional)

Controls how the animation loops.

- `true` (default)  
  The animation loops infinitely.

- `false`  
  The animation plays once and stops.

```ruby
GD::Gif.new("once.gif", loop: false)
```

---

## Behavior

- The output file is created during initialization
- The GIF header is written on the first `add_frame` call
- If no frames are added, the file remains empty
- Actual encoding happens when frames are added

---

## Notes

- Always call `close` to properly finalize the GIF
- Exiting without calling `close` may result in a corrupted file
- A single instance cannot be reused for multiple GIFs

---

## Related Methods

- [`add_frame`](add_frame.md)
- [`close`](close.md)
